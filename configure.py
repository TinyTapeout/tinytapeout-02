#!/usr/bin/env python3
import re, glob, json
import yaml
import argparse, logging, shutil, sys, os, collections
from git_utils import install_artifacts
import git
from project_urls import filler_project_url, test_project_urls, project_urls


# pipe handling
from signal import signal, SIGPIPE, SIG_DFL
signal(SIGPIPE, SIG_DFL)

tmp_dir = '/tmp/tt'
DEFAULT_NUM_PROJECTS = 473


def unique(duplist):
    unique_list = []
    # traverse for all elements
    for x in duplist:
        # check if exists in unique_list or not
        if x not in unique_list:
            unique_list.append(x)
    return unique_list


class Projects():

    def __init__(self, args):
        self.args = args
        # project urls are defined in project_urls module
        # by default, this method will fill empty slots with the 'filler project'
        if self.args.test:
            self.project_urls = test_project_urls
            project_dir = 'test_projects'
        else:
            self.project_urls = project_urls
            project_dir = 'projects'

        logging.info(f"loaded {len(self.project_urls)} projects")

        if not os.path.exists(project_dir):
            os.makedirs(project_dir)

        self.projects = []
        filler = False
        filler_id = 0
        for index in range(args.limit_num_projects):
            try:
                git_url = self.project_urls[index]
            except IndexError:
                if filler is False:
                    git_url = filler_project_url
                    filler_id = 0  # first project is always fill
                filler = True

            project = Project(index, git_url, project_dir, fill=filler, fill_id=filler_id)

            # clone git repos locally & gds artifacts from action build
            if args.clone_all:
                logging.info(f"cloning & fetching gds for {project}")
                if filler is False:
                    project.clone()
                    project.fetch_gds()

            # projects should now be installed, so load all the data from the yaml files
            logging.debug("loading project yaml")
            # fill projects will load from the fill project's directory
            project.load_yaml()

            if args.update_caravel:
                logging.debug("copying files to caravel")
                if filler is False:
                    project.copy_files_to_caravel()

                # check all top level module ports are correct
                project.check_ports()
                project.check_num_cells()

            self.projects.append(project)

        # now do some sanity checks
        all_macro_instances = [project.get_macro_instance() for project in self.projects]
        assert len(all_macro_instances) == len(unique(all_macro_instances))

        all_top_files = [project.get_top_verilog_file() for project in self.projects if not project.is_fill()]
        assert len(all_top_files) == len(unique(all_top_files))

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

    def check_ports(self):
        top = self.get_macro_name()
        sources = [os.path.join(self.local_dir, 'src', src) for src in self.src_files]
        source_list = " ".join(sources)

        json_file = 'ports.json'
        os.system("yosys -qp 'read_verilog -sv %s; hierarchy -top %s ; proc; json -o %s x:*'" % (source_list, top, json_file))
        with open(json_file) as fh:
            ports = json.load(fh)
        os.unlink(json_file)

        module_ports = ports['modules'][top]['ports']
        for port in ['io_in', 'io_out']:
            if port not in module_ports:
                logging.error(f"{port} not found in top")
                exit(1)
            if len(module_ports[port]['bits']) != 8:
                logging.error(f"{port} doesn't have 8 bits")
                exit(1)

    def check_num_cells(self):
        num_cells = 0
        yosys_report = glob.glob(f'{self.local_dir}/runs/wokwi/reports/synthesis/1-synthesis.*0.stat.rpt')[0]  # can't open a file with \ in the path
        with open(yosys_report) as fh:
            for line in fh.readlines():
                m = re.search(r'Number of cells:\s+(\d+)', line)
                if m is not None:
                    num_cells = int(m.group(1))
        if not self.fill and self.index != 0:
            if self.is_hdl():
                if num_cells < 20:
                    logging.warning(f"{self} only has {num_cells} cells")
            else:
                if num_cells < 11:
                    logging.warning(f"{self} only has {num_cells} cells")

    def is_fill(self):
        return self.fill

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
        self.yaml['project']['git_url'] = self.git_url

        if self.is_hdl():
            self.top_module         = self.yaml['project']['top_module']
            self.src_files          = self.yaml['project']['source_files']
            self.top_verilog_file   = self.find_top_verilog()
        else:
            self.top_module         = f"user_module_{self.wokwi_id}"
            self.src_files          = [f"user_module_{self.wokwi_id}.v"]
            self.top_verilog_file   = self.src_files[0]

        self.macro_instance         = f"{self.top_module}_{self.index}"
        self.scanchain_instance     = f"scanchain_{self.index}"

    # docs stuff for index on README.md
    def get_index_row(self):
        return f'| {self.yaml["documentation"]["author"]} | {self.yaml["documentation"]["title"]} | {self.get_project_type_string()} | {self.git_url} |\n'

    def get_project_type_string(self):
        if self.is_wokwi():
            return f"[Wokwi]({self.get_wokwi_url()})"
        else:
            return "HDL"

    def get_project_doc_yaml(self):
        # fstring dict support is limited to one level deep, so put the git url and wokwi url in the docs key
        docs = self.yaml['documentation']
        docs['project_type'] = self.get_project_type_string()
        docs['git_url'] = self.git_url
        return docs

    def get_wokwi_url(self):
        return f'https://wokwi.com/projects/{self.wokwi_id}'

    # top module name is defined in one of the source files, which one?
    def find_top_verilog(self):
        rgx_mod  = re.compile(r"(?:^|[\W])module[\s]{1,}([\w]+)")
        top_verilog = []
        for src in self.src_files:
            with open(os.path.join(self.local_dir, 'src', src)) as fh:
                for line in fh.readlines():
                    for match in rgx_mod.finditer(line):
                        if match.group(1) == self.top_module:
                            top_verilog.append(src)
        assert len(top_verilog) == 1
        return top_verilog[0]

    def clone(self):
        # could check if it already exists and then skip for faster local builds
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
        return self.top_module

    # instance name of the project, different for each id
    def get_macro_instance(self):
        return self.macro_instance

    # instance name of the scanchain module, different for each id
    def get_scanchain_instance(self):
        return self.scanchain_instance

    # unique id
    def get_index(self):
        return self.index

    # name of the gds file
    def get_macro_gds_name(self):
        return f"{self.top_module}.gds"

    def get_macro_lef_name(self):
        return f"{self.top_module}.lef"

    # for black boxing when building GDS, just need module name and ports
    def get_verilog_include(self):
        return f'`include "{self.get_top_verilog_file()}"\n'

    # for GL sims
    def get_gl_verilog_names(self):
        return f"{self.top_module}.v"

    def get_top_verilog_file(self):
        if self.is_hdl():
            # make sure it's unique and without leading directories
            filename = os.path.basename(self.top_verilog_file)
            return f'{self.index}_{filename}'
        else:
            return f'user_module_{self.wokwi_id}.v'

    # for the includes file for simulation
    def get_verilog_names(self):
        return [self.get_gl_verilog_names()]

    def get_git_url(self):
        return self.git_url

    def copy_files_to_caravel(self):
        if self.is_hdl():
            # this is going to fail if people use duplicate top module names
            # and can't be fixed by changing the name as that will not match with the gds or lef
            files = [
                (f"{self.index}/runs/wokwi/results/final/gds/{self.top_module}.gds", f"gds/{self.top_module}.gds"),
                (f"{self.index}/runs/wokwi/results/final/lef/{self.top_module}.lef", f"lef/{self.top_module}.lef"),
                (f"{self.index}/runs/wokwi/results/final/verilog/gl/{self.top_module}.v", f"verilog/gl/{self.top_module}.v"),
                (f"{self.index}/src/{self.top_verilog_file}", f"verilog/rtl/{self.get_top_verilog_file()}"),
                ]
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


class CaravelConfig():

    def __init__(self, projects, num_projects):
        self.projects = projects
        self.num_projects = num_projects

    # create macro file & positions, power hooks
    def create_macro_config(self):
        start_x = 80
        start_y = 80
        step_x  = 145
        step_y  = 135
        rows    = 25
        cols    = 19
        scanchain_w = 30
        scanchain_spc = 6
        module_w = 90
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
                            # co-ords are bottom left corner
                            macro_instance = self.projects[num_macros_placed].get_scanchain_instance()
                            instance = "{} {:<4} {:<4} {}\n".format(
                                macro_instance, start_x + col * step_x, start_y + row * step_y, orientation
                            )
                            fh.write(instance)

                            macro_instance = self.projects[num_macros_placed].get_macro_instance()
                            instance = "{} {:<4} {:<4} {}\n".format(
                                macro_instance, start_x + scanchain_spc + scanchain_w + col * step_x, start_y + row * step_y, orientation
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
                                macro_instance, start_x + module_w + scanchain_spc + col * step_x, start_y + row * step_y, orientation
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
        lefs = unique(lefs)
        gdss = unique(gdss)

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
            giturl = self.projects[idx].get_git_url()

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
        verilogs = unique(verilogs)

        with open('verilog/rtl/user_project_includes.v', 'w') as fh:
            fh.write('`include "scan_controller/scan_controller.v"\n')
            fh.write('`include "scanchain/scanchain.v"\n')
            for verilog in verilogs:
                fh.write(verilog)

        # build complete list of filenames for sim
        verilog_files = []
        for i in range(self.num_projects):
            verilog_files += self.projects[i].get_verilog_names()
        verilog_files = unique(verilog_files)
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
        verilog_files = unique(verilog_files)
        with open('verilog/includes/includes.gl.caravel_user_project', 'w') as fh:
            fh.write('-v $(USER_PROJECT_VERILOG)/gl/user_project_wrapper.v\n')
            fh.write('-v $(USER_PROJECT_VERILOG)/gl/scan_controller.v\n')
            fh.write('-v $(USER_PROJECT_VERILOG)/gl/scanchain.v\n')
            for verilog in verilog_files:
                fh.write('-v $(USER_PROJECT_VERILOG)/gl/{}\n'.format(verilog))

    def list(self):
        for project in self.projects:
            logging.info(project)


class Docs():

    def __init__(self, projects, args):
        self.projects = projects
        self.args = args

    # stuff related to docs
    def build_index(self):
        logging.info("building doc index")
        with open("README_init.md") as fh:
            readme = fh.read()
        with open("README.md", 'w') as fh:
            fh.write(readme)
            fh.write("| Author | Title | Type | Git Repo |\n")
            fh.write("| ------ | ------| -----| ---------|\n")
            for project in self.projects:
                if not project.is_fill():
                    fh.write(project.get_index_row())

    def update_image(self):
        cmd = "klayout -l caravel.lyp gds/user_project_wrapper.gds -r dump_pic.rb -c klayoutrc"
        logging.info(cmd)
        os.system(cmd)

    # create a json file of all the project info, this is then used by tinytapeout.com to show projects
    def dump_json(self):
        designs = []
        for project in self.projects:
            design = project.get_project_yaml()
            designs.append(design)

        with open(args.dump_json, "w") as fh:
            fh.write(json.dumps(designs, indent=4))
        logging.info(f'wrote json to {args.dump_json}')

    def dump_markdown(self):

        with open("doc_header.md") as fh:
            doc_header = fh.read()

        with open("doc_template.md") as fh:
            doc_template = fh.read()

        with open("INFO.md") as fh:
            doc_info = fh.read()

        with open(args.dump_markdown, 'w') as fh:
            fh.write(doc_header)

            for project in self.projects:
                if project.is_fill():
                    continue
                yaml_data = project.get_project_doc_yaml()

                logging.info(f"building datasheet for {project}")
                # handle pictures
                yaml_data['picture_link'] = ''
                if yaml_data['picture']:
                    # skip SVG for now, not supported by pandoc
                    picture_name = yaml_data['picture']
                    if 'svg' not in picture_name:
                        picture_filename = os.path.join(project.local_dir, picture_name)
                        yaml_data['picture_link'] = '![picture]({})'.format(picture_filename)

                # now build the doc & print it
                try:
                    doc = doc_template.format(**yaml_data)
                    fh.write(doc)
                    fh.write("\n\pagebreak\n")
                except IndexError:
                    logging.warning("missing pins in info.yaml, skipping")

            # ending
            fh.write(doc_info)

        logging.info(f'wrote markdown to {args.dump_markdown}')

        if args.dump_pdf:
            os.system(f'pandoc --toc --toc-depth 2 --pdf-engine=xelatex -i {args.dump_markdown} -o {args.dump_pdf}')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="TinyTapeout configuration and docs")

    parser.add_argument('--list', help="list projects", action='store_const', const=True)
    parser.add_argument('--clone-all', help="clone all projects", action="store_const", const=True)
    parser.add_argument('--update-caravel', help='configure caravel for build', action='store_const', const=True)
    parser.add_argument('--limit-num-projects', help='only configure for the first n projects', type=int, default=DEFAULT_NUM_PROJECTS)
    parser.add_argument('--test', help='use test projects', action='store_const', const=True)
    parser.add_argument('--debug', help="debug logging", action="store_const", dest="loglevel", const=logging.DEBUG, default=logging.INFO)
    parser.add_argument('--update-image', help="update the image", action="store_const", const=True)
    parser.add_argument('--dump-json', help="dump json of all project data to given file")
    parser.add_argument('--dump-markdown', help="dump markdown of all project data to given file")
    parser.add_argument('--dump-pdf', help="create pdf from the markdown")

    args = parser.parse_args()

    # setup log
    log_format = logging.Formatter('%(asctime)s - %(levelname)-8s - %(message)s')
    # configure the client logging
    log = logging.getLogger('')
    # has to be set to debug as is the root logger
    log.setLevel(args.loglevel)

    # create console handler and set level to info
    ch = logging.StreamHandler(sys.stdout)
    # create formatter for console
    ch.setFormatter(log_format)
    log.addHandler(ch)

    projects = Projects(args)
#    projects.check_dupes()

    docs = Docs(projects.projects, args=args)
    caravel = CaravelConfig(projects.projects, num_projects=args.limit_num_projects)

    if args.list:
        caravel.list()

    if args.update_caravel:
        caravel.create_macro_config()
        caravel.instantiate()
        if not args.test:
            docs.build_index()

    if args.update_image:
        docs.update_image()

    if args.dump_json:
        docs.dump_json()

    if args.dump_markdown:
        docs.dump_markdown()
