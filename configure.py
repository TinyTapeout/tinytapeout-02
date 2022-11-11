#!/usr/bin/env python3
import re
import yaml
from typing import List
from urllib.parse import urlparse
import argparse, requests, base64, io, logging, pickle, shutil, sys, os, collections, subprocess
from git_utils import fetch_file_from_git, install_artifacts
import git
from project_urls import filler_project_url, test_project_urls, project_urls

# pipe handling
from signal import signal, SIGPIPE, SIG_DFL
signal(SIGPIPE, SIG_DFL)

tmp_dir = '/tmp/tt'
DEFAULT_NUM_PROJECTS = 473


class Projects():

    def __init__(self, args):
        self.args = args
        # project urls are defined in project_urls module
        # by default, this method will fill empty slots with the 'filler project'
        self.project_urls = self.get_project_urls()
        assert len(self.project_urls) == DEFAULT_NUM_PROJECTS
        logging.info(f"loaded {len(self.project_urls)} projects")

        if args.test:
            project_dir = 'test_projects'
        else:
            project_dir = 'projects'

        self.projects = []
        filler = False
        filler_id = 0
        for index, git_url in enumerate(self.project_urls):
            if git_url == filler_project_url:
                if filler == False:
                    filler_id = index
                filler = True
            self.projects.append(Project(index, git_url, project_dir, fill=filler, fill_id=filler_id))
           
        if args.clone_single is not None:
            project = self.projects[args.clone_single]
            logging.info(f"cloning {project}")
            project.clone()

        # clone git repos locally
        if args.clone_all:
            first_fill = False
            for project in self.projects:
                if not first_fill:
                    logging.info(f"cloning {project}")
                    project.clone()
                    first_fill = project.fill

            # gds artifacts from action build
            first_fill = False
            for project in self.projects:
                if not first_fill:
                    logging.info(f"installing gds for {project}")
                    project.fetch_gds()
                    first_fill = project.fill

        # projects should now be installed, so load all the data from the yaml files
        # up to this point projects objects don't know themselves
        logging.info(f"loading project yaml")
        for project in self.projects:
            # fill projects will load from the fill project's directory
            project.load_yaml()

        logging.info(f"copying files to caravel")
        first_fill = False
        for project in self.projects:
            if not first_fill:
                project.copy_files_to_caravel()
                first_fill = project.fill
    
    def get_project_urls(self):
        if self.args.test:
            filler_projects = DEFAULT_NUM_PROJECTS - len(test_project_urls)
            return test_project_urls + filler_projects * [filler_project_url]
        else:
            filler_projects = DEFAULT_NUM_PROJECTS - len(project_urls)
            return project_urls + filler_projects * [filler_project_url]

    def check_dupes(self):
        from project_urls import project_urls
        duplicates = [item for item, count in collections.Counter(project_urls).items() if count > 1]
        if duplicates:
            logging.error("duplicate projects: {}".format(duplicates))
            exit(1)

class Project():

    def __init__(self, index, git_url, project_dir, fill, fill_id=0):
        self.git_url = git_url
        self.index = index
        self.fill = fill
        self.project_dir = project_dir
        self.local_dir = self.gen_local_dir(fill_id)

    # if the project is a filler, then use the config from the first fill project
    def gen_local_dir(self, fill_id):
        if self.fill:
            return os.path.join(os.path.join(self.project_dir, str(fill_id)))
        else:
            return os.path.join(os.path.join(self.project_dir, str(self.index)))

    def is_wokwi(self):
        if self.wokwi_id != 0:
            return True

    def is_hdl(self):
        return not self.is_wokwi()

    def load_yaml(self):
        try:
            with open(os.path.join(self.local_dir, 'info.yaml')) as fh:
                self.yaml = yaml.safe_load(fh)
        except FileNotFoundError:
            logging.error(f"yaml file not found for {self} - do you need to --clone the project repos?")
            exit(1)

        self.wokwi_id = self.yaml['project']['wokwi_id']

        if self.is_hdl():
            self.top_module = self.yaml['project']['top_module']
            self.src_files = self.yaml['project']['source_files']

    def clone(self):
        try:
            git.Repo.clone_from(self.git_url, self.local_dir)
        except git.exc.GitCommandError as e:
            if 'already exists' in str(e):
                logging.info("already exists")

    def update(self):
        # do a pull
        pass

    def __str__(self):
        return f"[{self.index:03} : {self.git_url}]"

    def fetch_gds(self):
        install_artifacts(self.git_url, self.local_dir)

    def get_macro_name(self):
        if self.is_hdl():
            return self.top_module
        else:
            return f"user_module_{self.wokwi_id}"

    # instance name of the project, different for each id
    def get_macro_instance(self):
        if self.is_hdl():
            return f"{self.top_module}_{self.index}"
        else:
            return f"user_module_{self.wokwi_id}_{self.index}"

    # instance name of the scanchain module, different for each id
    def get_scanchain_instance(self):
        return f"scanchain_{self.index}"

    # unique id
    def get_index(self):
        return self.index

    # name of the gds file
    def get_macro_gds_name(self):
        if self.is_hdl():
            return f"{self.top_module}.gds"
        else:
            # return diff if fill
            return f"user_module_{self.wokwi_id}.gds"

    def get_macro_lef_name(self):
        if self.is_hdl():
            return f"{self.top_module}.lef"
        else:
            # return diff if fill
            return f"user_module_{self.wokwi_id}.lef"

    # for black boxing when building GDS, just need module name and ports
    def get_verilog_include(self):
        if self.is_hdl():
            # wrong
            return f'`include "{self.top_module}.v"\n'
        else:
            # return diff if fill
            return f'`include "user_module_{self.wokwi_id}.v"\n'

    # for GL sims
    def get_gl_verilog_names(self):
        if self.is_hdl():
            return [f"{self.top_module}.v"]
        else:
            # return diff if fill
            return [f'user_module_{self.wokwi_id}.v']

    # for the includes file for simulation
    def get_verilog_names(self):
        if self.is_hdl():
            files = []
            for src in self.src_files:
                files.append(src)
            return files
        else:
            # return diff if fill
            return [f'user_module_{self.wokwi_id}.v']

    def get_giturl(self):
        return self.git_url

    def copy_files_to_caravel(self):
        if self.is_hdl():
            files = [
                (f"{self.index}/runs/wokwi/results/final/gds/{self.top_module}.gds", f"gds/{self.top_module}.gds"),
                (f"{self.index}/runs/wokwi/results/final/lef/{self.top_module}.lef", f"lef/{self.top_module}.lef"),
                (f"{self.index}/runs/wokwi/results/final/verilog/gl/{self.top_module}.v", f"verilog/gl/{self.top_module}.v"),
                ]
# Tholin has used * in src
            for src in self.src_files:
                files.append((f"{self.index}/src/{src}", f"verilog/rtl/{src}"))
        else:
            # copy all important files to the correct places. Everything is dependent on the id
            files = [
                (f"{self.index}/runs/wokwi/results/final/gds/user_module_{self.wokwi_id}.gds", f"gds/user_module_{self.wokwi_id}.gds"),
                (f"{self.index}/runs/wokwi/results/final/lef/user_module_{self.wokwi_id}.lef", f"lef/user_module_{self.wokwi_id}.lef"),
                (f"{self.index}/runs/wokwi/results/final/verilog/gl/user_module_{self.wokwi_id}.v", f"verilog/gl/user_module_{self.wokwi_id}.v"),
                (f"{self.index}/src/user_module_{self.wokwi_id}.v", f"verilog/rtl/user_module_{self.wokwi_id}.v"),
                ]

        logging.debug("copying files into position")
        for from_path, to_path in files:
            from_path = os.path.join(self.project_dir, from_path)
            logging.debug(f"copy {from_path} to {to_path}")
            shutil.copyfile(from_path, to_path)

        # Uniquify the Verilog for this project
#        self.uniquify_project(wokwi_id, [
#            f"verilog/rtl/user_module_{wokwi_id}.v",
#        ])


    def uniquify_project(self, wokwi_id : str, rtl_files : List[str]) -> None:
        """
        Ensure all modules within a given subproject include the Wokwi ID, this
        avoids collisions between names. This is a relatively simplistic function
        for uniquification, it could probably be improved a lot.

        :param wokwi_id:    The unique ID for the project
        :param rtl_files:   List of paths to Verilog files to uniquify
        """
        # Identify all of the module names in this project
        rgx_mod  = re.compile(r"(?:^|[\W])module[\s]{1,}([\w]+)")
        all_mod  = set()
        full_txt = {}
        for path in rtl_files:
            with open(path, "r", encoding="utf-8") as fh:
                # Pull in full text
                full_txt[path] = list(fh.readlines())
                # Strip single and multi line comments
                in_block = False
                clean    = []
                for line in full_txt[path]:
                    if "/*" in line and "*/" in line:
                        line = line.split("/*")[0] + line.split("*/")[1]
                    elif "/*" in line:
                        line     = line.split("/*")[0]
                        in_block = True
                    elif in_block and "*/" in line:
                        line     = line.split("*/")[1]
                        in_block = False
                    clean.append(line.split("//")[0].strip())
                # Join cleaned up lines together
                flat_text = " ".join(clean)
                # Search for 'module X' declarations
                for match in rgx_mod.finditer(flat_text):
                    all_mod.add(match.group(1))
        # Replace just the names which don't contain the Wokwi ID
        problems = { x for x in all_mod if str(wokwi_id) not in x }
        if problems:
            # Create regular expression to match uses of the module name
            rgx_repl = re.compile(rf"\b({'|'.join(problems)})\b")
            # Run through each Verilog file
            for path, orig_txt in full_txt.items():
                new_txt = []
                for line in orig_txt:
                    # For every match, substitute with a safe module name
                    for match in list(rgx_repl.finditer(line))[::-1]:
                        m_start, m_end = match.span()
                        m_sub          = f"{match.group(1)}_{wokwi_id}"
                        line           = line[:m_start] + m_sub + line[m_end:]
                        # Some projects seem to have hardcoded RTL and forgotten
                        # to replace 'USER_MODULE_ID' with the Wokwi ID
                        if "_USER_MODULE_ID_" in line:
                            line = line.replace("_USER_MODULE_ID_", "_")
                    new_txt.append(line)
                # Overwrite the file
                logging.info(f"Writing uniquified RTL for {path}")
                with open(path, "w", encoding="utf-8") as fh:
                    fh.writelines(new_txt)

class CaravelConfig():

    def __init__(self, projects, num_projects):
        self.projects = projects
        self.num_projects = num_projects

    @classmethod
    def unique(cls, duplist):
        unique_list = []
        # traverse for all elements
        for x in duplist:
            # check if exists in unique_list or not
            if x not in unique_list:
                unique_list.append(x)
        return unique_list

    # create macro file & positions, power hooks
    def create_macro_config(self):
        start_x = 80
        start_y = 80
        step_x  = 145
        step_y  = 135
        rows    = 25
        cols    = 19
        scanchain_w = 36
        num_macros_placed = 0

        # macro.cfg: where macros are placed
        logging.info("creating macro.cfg")
        with open("openlane/user_project_wrapper/macro.cfg", 'w') as fh:
            fh.write("scan_controller 80 80 N\n")
            for row in range(rows):
                if(row % 2 == 0):
                    col_order = range(cols)
                    orientation = 'N'
                else:
                    # reverse odd rows to place instances in a zig zag pattern, shortening the scan chain wires
                    col_order = range(cols - 1, -1, -1)
                    orientation = 'S'
                for col in col_order:
                    # skip the space where the scan controller goes on the first row
                    if row == 0 and col <= 1:
                        continue

                    if num_macros_placed < self.num_projects:
                        if orientation == 'N':
                            # scanchain first
                            macro_instance = self.projects[num_macros_placed].get_scanchain_instance()
                            instance = "{} {:<4} {:<4} {}\n".format(
                                macro_instance, start_x + col * step_x, start_y + row * step_y, orientation
                            )
                            fh.write(instance)

                            macro_instance = self.projects[num_macros_placed].get_macro_instance()
                            instance = "{} {:<4} {:<4} {}\n".format(
                                macro_instance, start_x + scanchain_w + col * step_x, start_y + row * step_y, orientation
                            )
                            fh.write(instance)
                        else:
                            # macro first
                            macro_instance = self.projects[num_macros_placed].get_macro_instance()
                            instance = "{} {:<4} {:<4} {}\n".format(
                                macro_instance, start_x + col * step_x, start_y + row * step_y, orientation
                            )
                            fh.write(instance)

                            macro_instance = self.projects[num_macros_placed].get_scanchain_instance()
                            instance = "{} {:<4} {:<4} {}\n".format(
                                macro_instance, start_x + (step_x - scanchain_w) + col * step_x, start_y + row * step_y, orientation
                            )
                            fh.write(instance)

                    num_macros_placed += 1

        logging.info(f"total user macros placed: {num_macros_placed}")

        # macro_power.tcl: extra file for macro power hooks
        logging.info("creating macro_power.tcl")
        with open("openlane/user_project_wrapper/macro_power.tcl", 'w') as fh:
            fh.write('set ::env(FP_PDN_MACRO_HOOKS) "\\\n')
            fh.write("	")
            fh.write("scan_controller")
            fh.write(" vccd1 vssd1 vccd1 vssd1")
            fh.write(", \\\n")
            for i in range(self.num_projects):
                fh.write("	")
                fh.write(self.projects[i].get_scanchain_instance())
                fh.write(" vccd1 vssd1 vccd1 vssd1, \\\n")
                fh.write("	")
                fh.write(self.projects[i].get_macro_instance())
                fh.write(" vccd1 vssd1 vccd1 vssd1")
                if i != self.num_projects - 1:
                    fh.write(", \\\n")
            fh.write('"\n')

        # extra_lef_gds.tcl
        logging.info("creating extra_lef_gds.tcl")
        lefs = []
        gdss = []
        for i in range(self.num_projects):
            lefs.append(self.projects[i].get_macro_lef_name())
            gdss.append(self.projects[i].get_macro_gds_name())

        # can't have duplicates or OpenLane crashes at PDN
        lefs = CaravelConfig.unique(lefs)
        gdss = CaravelConfig.unique(gdss)

        with open("openlane/user_project_wrapper/extra_lef_gds.tcl", 'w') as fh:
            fh.write('set ::env(EXTRA_LEFS) "\\\n')
            fh.write("$script_dir/../../lef/scan_controller.lef \\\n")
            fh.write("$script_dir/../../lef/scanchain.lef \\\n")
            for i, lef in enumerate(lefs):
                fh.write("$script_dir/../../lef/{}".format(lef))
                if i != len(lefs) - 1:
                    fh.write(" \\\n")
                else:
                    fh.write('"\n')
            fh.write('set ::env(EXTRA_GDS_FILES) "\\\n')
            fh.write("$script_dir/../../gds/scan_controller.gds \\\n")
            fh.write("$script_dir/../../gds/scanchain.gds \\\n")
            for i, gds in enumerate(gdss):
                fh.write("$script_dir/../../gds/{}".format(gds))
                if i != len(gdss) - 1:
                    fh.write(" \\\n")
                else:
                    fh.write('"\n')

    # instantiate inside user_project_wrapper
    def instantiate(self):
        logging.info("instantiating designs in user_project_wrapper.v")

        # NOTE: The user project wrapper initially used vectored signals for clk,
        #       scan, and latch signals. However, this leads to atrocious sim
        #       performance, as any change within the vectored signal is
        #       interpreted as a trigger condition for re-evaluating logic (at
        #       least this is the case under Icarus and Verilator). Therefore
        #       single bit signals are used between stages to limit the impact
        #       of any wire changing.

        # Instance the scan controller
        body = [
            "",
            "wire sc_clk_out, sc_data_out, sc_latch_out, sc_scan_out;",
            "wire sc_clk_in,  sc_data_in;",
            "",
            f"scan_controller #(.NUM_DESIGNS({self.num_projects})) scan_controller (",
            "   .clk                    (wb_clk_i),",
            "   .reset                  (wb_rst_i),",
            "   .active_select          (io_in[20:12]),",
            "   .inputs                 (io_in[28:21]),",
            "   .outputs                (io_out[36:29]),",
            "   .ready                  (io_out[37]),",
            "   .slow_clk               (io_out[10]),",
            "   .set_clk_div            (io_in[11]),",
            "",
            "   .scan_clk_out           (sc_clk_out),",
            "   .scan_clk_in            (sc_clk_in),",
            "   .scan_data_out          (sc_data_out),",
            "   .scan_data_in           (sc_data_in),",
            "   .scan_select            (sc_scan_out),",
            "   .scan_latch_en          (sc_latch_out),",
            "",
            "   .la_scan_clk_in         (la_data_in[0]),",
            "   .la_scan_data_in        (la_data_in[1]),",
            "   .la_scan_data_out       (la_data_out[0]),",
            "   .la_scan_select         (la_data_in[2]),",
            "   .la_scan_latch_en       (la_data_in[3]),",
            "",
            "   .driver_sel             (io_in[9:8]),",
            "",
            "   .oeb                    (io_oeb)",
            ");",
        ]

        # Instance every design on the scan chain
        for idx in range(self.num_projects):
            # First design driven by scan controller, all others are chained
            pfx      = f"sw_{idx:03d}"
            prev_pfx = f"sw_{idx-1:03d}" if idx > 0 else "sc"
            # Pickup the Wokwi design ID and github URL for the project
            index  = self.projects[idx].get_index()
            giturl = self.projects[idx].get_giturl()

            # Append the instance to the body
            body += [
                "",
                f"// [{idx:03d}] {giturl}",
                f"wire {pfx}_clk_out, {pfx}_data_out, {pfx}_scan_out, {pfx}_latch_out;",
                f"wire [7:0] {pfx}_module_data_in;",
                f"wire [7:0] {pfx}_module_data_out;",
                f"scanchain #(.NUM_IOS(8)) {self.projects[idx].get_scanchain_instance()} (",
                f"    .clk_in          ({prev_pfx}_clk_out),",
                f"    .data_in         ({prev_pfx}_data_out),",
                f"    .scan_select_in  ({prev_pfx}_scan_out),",
                f"    .latch_enable_in ({prev_pfx}_latch_out),",
                f"    .clk_out         ({pfx}_clk_out),",
                f"    .data_out        ({pfx}_data_out),",
                f"    .scan_select_out ({pfx}_scan_out),",
                f"    .latch_enable_out({pfx}_latch_out),",
                f"    .module_data_in  ({pfx}_module_data_in),",
                f"    .module_data_out ({pfx}_module_data_out)",
                ");"
            ]

            # Append the user module to the body
            body += [
                "",
                f"{self.projects[idx].get_macro_name()} {self.projects[idx].get_macro_instance()} (",
                f"    .io_in  ({pfx}_module_data_in),",
                f"    .io_out ({pfx}_module_data_out)",
                ");"

            ]

        # Link the final design back to the scan controller
        body += [
            "",
            "// Connect final signals back to the scan controller",
            f"assign sc_clk_in  = sw_{idx:03d}_clk_out;",
            f"assign sc_data_in = sw_{idx:03d}_data_out;",
            "",
            ""
        ]

        # Write to file
        with open('verilog/rtl/user_project_wrapper.v', 'w') as fh:
            # Insert the Caravel preamble
            with open("upw_pre.v", "r") as fh_pre:
                fh.write(fh_pre.read())
            # Indent, join, and insert the module instances
            fh.write("\n".join([("    " + x).rstrip() for x in body]))
            # Insert the Caravel postamble
            with open("upw_post.v", "r") as fh_post:
                fh.write(fh_post.read())

        # build the user_project_includes.v file - used for blackboxing when building the GDS
        verilogs = []
        for i in range(self.num_projects):
            verilogs.append(self.projects[i].get_verilog_include())
        verilogs = CaravelConfig.unique(verilogs)

        with open('verilog/rtl/user_project_includes.v', 'w') as fh:
            fh.write('`include "scan_controller/scan_controller.v"\n')
            fh.write('`include "scanchain/scanchain.v"\n')
            for verilog in verilogs:
                fh.write(verilog)

        # build complete list of filenames for sim
        verilog_files = []
        for i in range(self.num_projects):
            verilog_files += self.projects[i].get_verilog_names()
        verilog_files = CaravelConfig.unique(verilog_files)
        with open('verilog/includes/includes.rtl.caravel_user_project', 'w') as fh:
            fh.write('-v $(USER_PROJECT_VERILOG)/rtl/user_project_wrapper.v\n')
            fh.write('-v $(USER_PROJECT_VERILOG)/rtl/scan_controller/scan_controller.v\n')
            fh.write('-v $(USER_PROJECT_VERILOG)/rtl/scanchain/scanchain.v\n')
            fh.write('-v $(USER_PROJECT_VERILOG)/rtl/cells.v\n')
            for verilog in verilog_files:
                fh.write('-v $(USER_PROJECT_VERILOG)/rtl/{}\n'.format(verilog))

        # build GL includes
        verilog_files = []
        for i in range(self.num_projects):
            verilog_files += self.projects[i].get_gl_verilog_names()
        verilog_files = CaravelConfig.unique(verilog_files)
        with open('verilog/includes/includes.gl.caravel_user_project', 'w') as fh:
            fh.write('-v $(USER_PROJECT_VERILOG)/gl/user_project_wrapper.v\n')
            fh.write('-v $(USER_PROJECT_VERILOG)/gl/scan_controller.v\n')
            fh.write('-v $(USER_PROJECT_VERILOG)/gl/scanchain.v\n')
            for verilog in verilog_files:
                fh.write('-v $(USER_PROJECT_VERILOG)/gl/{}\n'.format(verilog))

    def build_docs(self):
        pass
        """
        logging.info("building doc index")
        with open("README_init.md") as fh:
            readme = fh.read()
        with open("README.md", 'w') as fh:
            fh.write(readme)
            for wokwi_id, project_url in zip(self.projects.get_wokwi_ids(), self.projects.get_project_urls()):
                fh.write("* [{}]({}) {}\n".format(wokwi_id, Projects.build_wokwi_url(wokwi_id), project_url))
        """

    def list(self):
        count = 0
        for wokwi_id, project_url in zip(self.projects.get_wokwi_ids(), self.projects.get_project_urls()):
            logging.info("{:3} {:20} {}".format(count, wokwi_id, project_url))
            count += 1

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="TinyTapeout")

    parser.add_argument('--list', help="list projects", action='store_const', const=True)
    parser.add_argument('--clone-all', help="clone all projects", action="store_const", const=True)
    parser.add_argument('--clone-single', help='only fetch a single repo for debug', type=int)
    parser.add_argument('--update-caravel', help='configure caravel for build', action='store_const', const=True)
    parser.add_argument('--limit-num-projects', help='only configure for the first n projects', type=int, default=DEFAULT_NUM_PROJECTS)
    parser.add_argument('--test', help='use test projects', action='store_const', const=True)
    parser.add_argument('--debug', help="debug logging", action="store_const", dest="loglevel", const=logging.DEBUG, default=logging.INFO)


    args = parser.parse_args()

    # setup log
    log_format = logging.Formatter('%(asctime)s - %(levelname)-8s - %(message)s')
    # configure the client logging
    log = logging.getLogger('')
    # has to be set to debug as is the root logger
    log.setLevel(args.loglevel)
    # turn off debug logging for requests
    logging.getLogger("requests").setLevel(logging.INFO)
    logging.getLogger("urllib3").setLevel(logging.INFO)

    # create console handler and set level to info
    ch = logging.StreamHandler(sys.stdout)
    # create formatter for console
    ch.setFormatter(log_format)
    log.addHandler(ch)

    projects = Projects(args)
    projects.check_dupes()

    caravel = CaravelConfig(projects.projects, num_projects=args.limit_num_projects)

    if args.list:
        caravel.list()

    if args.update_caravel:
        caravel.create_macro_config()
        caravel.instantiate()
        if not args.test:
            caravel.build_docs()
