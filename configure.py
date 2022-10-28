#!/usr/bin/env python3
import re
import yaml
from typing import List
from urllib.parse import urlparse
import argparse, requests, base64, zipfile, io, logging, pickle, shutil, sys, os, collections, subprocess

# pipe handling
from signal import signal, SIGPIPE, SIG_DFL
signal(SIGPIPE, SIG_DFL)

tmp_dir = '/tmp/tt'
DEFAULT_NUM_PROJECTS = 473


class Projects():

    def __init__(self, update_cache=False, update_single=None, test=False):
        self.default_project = 0
        self.test = test
        if update_cache:
            logging.info("updating cache, this could take a while")
            self.update_cache(update_single)
        else:
            # load projects from cache
            try:
                self.wokwi_ids = pickle.load(open(self.get_projects_db(), 'rb'))
                logging.info("loaded {} projects".format(len(self.wokwi_ids)))
            except FileNotFoundError:
                logging.error("project cache {} not found, use --update-cache to build it".format(self.get_projects_db()))

        # all ids must be unique
        assert len(set(self.wokwi_ids)) == len(self.wokwi_ids)

    def update_cache(self, update_single=None):
        self.wokwi_ids = []
        for url in self.get_project_urls():
            if update_single is not None:
                if url != update_single:
                    continue
            wokwi_id = self.install_artifacts(url)
            if wokwi_id in self.wokwi_ids:
                logging.error("wokwi id already exists!")
                exit(1)
            self.wokwi_ids.append(wokwi_id)

        # cache it
        with open(self.get_projects_db(), 'wb') as fh:
            pickle.dump(self.wokwi_ids, fh)

    def get_projects_db(self):
        if self.test:
            return "projects_test.pkl"
        else:
            return "projects.pkl"

    # filling the space with default projects is handled by returning the default on exception
    def get_macro_instance(self, id):
        try:
            return "user_module_{}_{}".format(self.wokwi_ids[id], id)
        except IndexError:
            return "user_module_{}_{}".format(self.wokwi_ids[self.default_project], id)

    def get_scanchain_instance(self, id):
        try:
            return "scanchain_{}".format(id)
        except IndexError:
            return "scanchain_{}".format(id)

    def get_wokwi_id(self, id):
        try:
            return self.wokwi_ids[id]
        except IndexError:
            return self.wokwi_ids[self.default_project]

    def get_macro_gds_name(self, id):
        try:
            return "user_module_{}.gds".format(self.wokwi_ids[id])
        except IndexError:
            return "user_module_{}.gds".format(self.wokwi_ids[self.default_project])

    def get_macro_lef_name(self, id):
        try:
            return "user_module_{}.lef".format(self.wokwi_ids[id])
        except IndexError:
            return "user_module_{}.lef".format(self.wokwi_ids[self.default_project])

    def get_macro_name(self, id):
        try:
            return "user_module_{}".format(self.wokwi_ids[id])
        except IndexError:
            return "user_module_{}".format(self.wokwi_ids[self.default_project])

    def get_verilog_include(self, id):
        try:
            return '`include "user_module_{}.v"\n'.format(self.wokwi_ids[id])
        except IndexError:
            return ''

    def get_gl_verilog_names(self, id):
        try:
            return ['user_module_{}.v'.format(self.wokwi_ids[id])]
        except IndexError:
            return []

    def get_verilog_names(self, id):
        try:
            return ["user_module_{}.v".format(self.wokwi_ids[id])]
        except IndexError:
            return []

    def get_wokwi_ids(self):
        return self.wokwi_ids

    def get_giturl(self, id):
        try:
            return self.get_project_urls()[id]
        except IndexError:
            return self.get_project_urls()[self.default_project]

    @classmethod
    def build_wokwi_url(Project, wokwi_id):
        return "https://wokwi.com/projects/{}".format(wokwi_id)

    def get_project_urls(self):
        if self.test:
            from project_urls_test import project_urls, filler_project_url
        else:
            from project_urls import project_urls, filler_project_url

        return [filler_project_url] + project_urls

    def check_dupes(self):
        project_urls = self.get_project_urls()
        duplicates = [item for item, count in collections.Counter(project_urls).items() if count > 1]
        if duplicates:
            logging.error("duplicate projects: {}".format(duplicates))
            exit(1)

    @classmethod
    def load_yaml(project, yaml_file):
        with open(yaml_file, "r") as stream:
            return (yaml.safe_load(stream))

    @classmethod
    def get_wokwi_id_from_yaml(project, yaml):
        # wokwi_id must be an int or 0
        try:
            wokwi_id = int(yaml['project']['wokwi_id'])
            return wokwi_id
        except ValueError:
            logging.error("wokwi id must be an integer")
            exit(1)

    # the latest artifact isn't necessarily the one related to the latest commit, as github
    # could have taken longer to process an older commit than a newer one.
    # so iterate through commits and return the artifact that matches
    @classmethod
    def get_most_recent_action_url(project, commits, artifacts):
        release_sha_to_download_url = {artifact['workflow_run']['head_sha']: artifact['archive_download_url'] for artifact in artifacts}
        for commit in commits:
            if commit['sha'] in release_sha_to_download_url:
                return release_sha_to_download_url[commit['sha']]

    @classmethod
    def split_git_url(Project, url):
        res = urlparse(url)
        try:
            _, user_name, repo = res.path.split('/')
        except ValueError:
            logging.error("couldn't split repo from {}".format(url))
            exit(1)
        repo = repo.replace('.git', '')
        return user_name, repo

    # download the artifact for each project to get the gds & lef
    def install_artifacts(self, url):
        logging.debug(url)
        user_name, repo = Projects.split_git_url(url)

        # authenticate for rate limiting
        auth_string = os.environ['GH_USERNAME'] + ':' + os.environ['GH_TOKEN']
        encoded = base64.b64encode(auth_string.encode('ascii'))
        headers = {
            "authorization" : 'Basic ' + encoded.decode('ascii'),
            "Accept"        : "application/vnd.github+json",
            }

        # first fetch the git commit history
        api_url = 'https://api.github.com/repos/{}/{}/commits'.format(user_name, repo)
        r = requests.get(api_url, headers=headers)
        requests_remaining = int(r.headers['X-RateLimit-Remaining'])
        if requests_remaining == 0:
            logging.error("no API requests remaining")
            exit(1)

        commits = r.json()

        # now get the artifacts
        api_url = 'https://api.github.com/repos/{}/{}/actions/artifacts'.format(user_name, repo)
        r = requests.get(api_url, headers=headers)
        data = r.json()

        # check there are some artifacts
        if 'artifacts' not in data:
            logging.error("no artifact found for {}".format(self))
            exit(1)
        else:
            # only get artifacts called GDS
            artifacts = [a for a in data['artifacts'] if a['name'] == 'GDS']
            logging.debug("found {} artifacts".format(len(artifacts)))

        if len(artifacts) == 0:
            logging.error("no artifacts for this project")
            exit(1)

        download_url = Projects.get_most_recent_action_url(commits, artifacts)
        logging.debug("download url {}".format(download_url))

        # need actions access on the token to get the artifact
        # won't work on a pull request because they won't have the token
        r = requests.get(download_url, headers=headers)
        z = zipfile.ZipFile(io.BytesIO(r.content))
        z.extractall(tmp_dir)

        # get the wokwi id
        info_yaml = Projects.load_yaml(os.path.join(tmp_dir, 'src/info.yaml'))
        wokwi_id = Projects.get_wokwi_id_from_yaml(info_yaml)

        logging.info("wokwi id {} github url {}".format(wokwi_id, url))

        # copy all important files to the correct places. Everything is dependent on the id
        files = [
            ("/tmp/tt/runs/wokwi/results/final/gds/user_module_{}.gds".format(wokwi_id), "gds/user_module_{}.gds".format(wokwi_id)),
            ("/tmp/tt/runs/wokwi/results/final/lef/user_module_{}.lef".format(wokwi_id), "lef/user_module_{}.lef".format(wokwi_id)),
            ("/tmp/tt/runs/wokwi/results/final/verilog/gl/user_module_{}.v".format(wokwi_id), "verilog/gl/user_module_{}.v".format(wokwi_id)),
            ("/tmp/tt/src/user_module_{}.v".format(wokwi_id), "verilog/rtl/user_module_{}.v".format(wokwi_id)),
            ]

        logging.debug("copying files into position")
        for from_path, to_path in files:
            logging.debug(f"copy {from_path} to {to_path}")
            shutil.copyfile(from_path, to_path)

        # Uniquify the Verilog for this project
        self.uniquify_project(wokwi_id, [
            f"verilog/rtl/user_module_{wokwi_id}.v",
        ])

        # unlink temp directory
        shutil.rmtree(tmp_dir)
        return wokwi_id

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
                            macro_instance = self.projects.get_scanchain_instance(num_macros_placed)
                            instance = "{} {:<4} {:<4} {}\n".format(
                                macro_instance, start_x + col * step_x, start_y + row * step_y, orientation
                            )
                            fh.write(instance)

                            macro_instance = self.projects.get_macro_instance(num_macros_placed)
                            instance = "{} {:<4} {:<4} {}\n".format(
                                macro_instance, start_x + scanchain_w + col * step_x, start_y + row * step_y, orientation
                            )
                            fh.write(instance)
                        else:
                            # macro first
                            macro_instance = self.projects.get_macro_instance(num_macros_placed)
                            instance = "{} {:<4} {:<4} {}\n".format(
                                macro_instance, start_x + col * step_x, start_y + row * step_y, orientation
                            )
                            fh.write(instance)

                            macro_instance = self.projects.get_scanchain_instance(num_macros_placed)
                            instance = "{} {:<4} {:<4} {}\n".format(
                                macro_instance, start_x + (step_x - scanchain_w) + col * step_x, start_y + row * step_y, orientation
                            )
                            fh.write(instance)

                    num_macros_placed += 1

        logging.info("total user macros placed: {}".format(num_macros_placed))

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
                fh.write(self.projects.get_scanchain_instance(i))
                fh.write(" vccd1 vssd1 vccd1 vssd1, \\\n")
                fh.write("	")
                fh.write(self.projects.get_macro_instance(i))
                fh.write(" vccd1 vssd1 vccd1 vssd1")
                if i != self.num_projects - 1:
                    fh.write(", \\\n")
            fh.write('"\n')

        # extra_lef_gds.tcl
        logging.info("creating extra_lef_gds.tcl")
        lefs = []
        gdss = []
        for i in range(self.num_projects):
            lefs.append(self.projects.get_macro_lef_name(i))
            gdss.append(self.projects.get_macro_gds_name(i))

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
            wk_id  = self.projects.get_wokwi_id(idx)
            giturl = self.projects.get_giturl(idx)
            logging.debug("instance %(idx)d user_module_%(wk_id)s", { "idx"  : idx,
                                                                       "wk_id": wk_id })
            # Append the instance to the body
            body += [
                "",
                f"// [{idx:03d}] {giturl}",
                f"wire {pfx}_clk_out, {pfx}_data_out, {pfx}_scan_out, {pfx}_latch_out;",
                f"wire [7:0] {pfx}_module_data_in;",
                f"wire [7:0] {pfx}_module_data_out;",
                f"scanchain #(.NUM_IOS(8)) {self.projects.get_scanchain_instance(idx)} (",
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
                f"user_module_{wk_id} {self.projects.get_macro_instance(idx)} (",
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
            verilogs.append(self.projects.get_verilog_include(i))
        verilogs = CaravelConfig.unique(verilogs)

        with open('verilog/rtl/user_project_includes.v', 'w') as fh:
            fh.write('`include "scan_controller/scan_controller.v"\n')
            fh.write('`include "scanchain/scanchain.v"\n')
            for verilog in verilogs:
                fh.write(verilog)

        # build complete list of filenames for sim
        verilog_files = []
        for i in range(self.num_projects):
            verilog_files += self.projects.get_verilog_names(i)
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
            verilog_files += self.projects.get_gl_verilog_names(i)
        verilog_files = CaravelConfig.unique(verilog_files)
        with open('verilog/includes/includes.gl.caravel_user_project', 'w') as fh:
            fh.write('-v $(USER_PROJECT_VERILOG)/gl/user_project_wrapper.v\n')
            fh.write('-v $(USER_PROJECT_VERILOG)/gl/scan_controller.v\n')
            fh.write('-v $(USER_PROJECT_VERILOG)/gl/scanchain.v\n')
            for verilog in verilog_files:
                fh.write('-v $(USER_PROJECT_VERILOG)/gl/{}\n'.format(verilog))

    def build_docs(self):
        logging.info("building doc index")
        with open("README_init.md") as fh:
            readme = fh.read()
        with open("README.md", 'w') as fh:
            fh.write(readme)
            for wokwi_id, project_url in zip(self.projects.get_wokwi_ids(), self.projects.get_project_urls()):
                fh.write("* [{}]({}) {}\n".format(wokwi_id, Projects.build_wokwi_url(wokwi_id), project_url))

    # requires tinytapeout_scan repo to be installed - use --recursive when cloning this repo
    # also needs a mod to sby, so probably ignore this unless you're Matt
    def formal_scan(self):
        cwd = os.getcwd()
        gl_dir = 'verilog/gl/'
        formal_dir = 'tinytapeout_scan'
        for i in range(self.num_projects):
            gl_filename = self.projects.get_gl_verilog_names(i)[0]
            shutil.copyfile(os.path.join(gl_dir, gl_filename), os.path.join(formal_dir, gl_filename))
            os.chdir(formal_dir)
            commands = ['sby', '-f', 'tinytapeout_scan.sby', gl_filename.rstrip('.v')]
            logging.info(commands)
            subprocess.run(commands, check=True)
            os.chdir(cwd)

    def list(self):
        count = 0
        for wokwi_id, project_url in zip(self.projects.get_wokwi_ids(), self.projects.get_project_urls()):
            logging.info("{:3} {:20} {}".format(count, wokwi_id, project_url))
            count += 1


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="TinyTapeout")

    parser.add_argument('--list', help="list projects", action='store_const', const=True)
    parser.add_argument('--update-projects', help='fetch the project data', action='store_const', const=True)
    parser.add_argument('--update-single', help='only fetch a single repo for debug')
    parser.add_argument('--update-caravel', help='configure caravel for build', action='store_const', const=True)
    parser.add_argument('--limit-num-projects', help='only configure for the first n projects', type=int, default=DEFAULT_NUM_PROJECTS)
    parser.add_argument('--test', help='use test projects', action='store_const', const=True)
    parser.add_argument('--debug', help="debug logging", action="store_const", dest="loglevel", const=logging.DEBUG, default=logging.INFO)

    # stuff for help with applying patches to all designs and re-hardening
    # parser.add_argument('--clone-all', help="clone all projects", action="store_const", const=True)
    parser.add_argument('--formal', help="formal scan proof", action="store_const", const=True)
    # parser.add_argument('--summary', help="summary", action="store_const", const=True)

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

    projects = Projects(update_cache=args.update_projects, test=args.test, update_single=args.update_single)
    projects.check_dupes()

    caravel = CaravelConfig(projects, num_projects=args.limit_num_projects)

    if args.formal:
        caravel.formal_scan()
    if args.list:
        caravel.list()

    if args.update_caravel:
        caravel.create_macro_config()
        caravel.instantiate()
        if not args.test:
            caravel.build_docs()
