#!/usr/bin/python3
usage = """toplevel_sta.py <path to main verilog> <path to spefs> <path to sdc> [-i]

To perform toplevel STA on tinytapeout style designs, where have a lot of individual module
verilogs and spefs

NB the -i flag means that after analysis has run it remains in STA interactively rather than 
quitting

Created by Jeremy Birch, 15/3/2023

anticipates openlane is installed in ~ - if it is not then either edit this code or put in symlinks to suit

reads the master verilog, anticipates all module verilogs are in the same directory, makes a merged_ verilog
with all the modules in it - NB we could probably just write a script that read the netlists in order and then 
linked but this allows us to use the openlane read_netlist command

walks over the master verilog to find all modules - uses this to both build the merged version and to determine
what spefs to load to annotate the design in its entirety, writes a script to load the various spefs into the
instances

writes a tcl script for STA derived from that used in openlane but altered to read the spef script etc

writes a shell script to invoke sta, then calls it

NB OpenSTA/app/sta needs to be on the PATH
NB this uses a slightly altered version of the python3 verilog parser (because it was wrong!)

TODO:
expand this to create relevant constraints for each embedded module

example usage:
python3 ./toplevel_sta.py ./verilog/gl/user_project_wrapper.v ./spef/user_project_wrapper.spef ./top.sdc
"""

#set the search path so we pickup our (modified) version of the verilog parser
import os
import sys
import re

#to use our hacked version of the verilog parser
#sys.path=["./verilog-parser-0.0.1"] + sys.path

from verilog_parser.parser import parse_verilog
import traceback

def includeFile(filename,ostrm):
    istrm=open(filename,"r")
    for line in istrm:
        ostrm.write(line)
        
    istrm.close()

#make a noodled verilog just for the parser - this is NOT included in the merged verilog
#otherwise we will mismatch the SPEF etc
def preprocessVerilog(vpath):
    #create a new verilog that swaps inout for input and loses escapes
    #to get past issues with the verilog parser
    newfile=vpath+"_edited"
    istrm=open(vpath,"r")
    ostrm=open(newfile,"w")
    for line in istrm:
        line=re.sub("^\s*inout\s"," input ",line,1)
        # \\\\ converts to literal \ in the input
        # (?P<name>pat) names the things that match pat so it can be put back in the replacement section
        line=re.sub("\\\\(?P<start>[^[]*)\[(?P<ind>[0-9]*)\]","\g<start>_\g<ind>_",line)
        ostrm.write(line)

    ostrm.close()
    istrm.close()
    
    return newfile
    
    
print(sys.argv)

ok=False
interactive=False

if len(sys.argv)==4:
    script,vpath,spath,sdc=sys.argv
    ok=True
elif len(sys.argv)==5:
    script,vpath,spath,sdc,di=sys.argv
    if di=="-i":
        interactive=True
        ok=True    
    
if not ok:
    print("ERROR - "+usage)
    exit(-1)

if not os.path.isfile(vpath):
    print("Verilog file missing - %s\n"%vpath)
    exit(-1)
    
if not os.path.isfile(spath):
    print("Master SPEF file missing - %s\n"%spath)
    exit(-1)

if not os.path.isfile(sdc):
    print("SDC file missing - %s\n"%sdc)
    exit(-1)

#preprocess the verilog to work round the inout/escaped names issues
mvpath=preprocessVerilog(vpath)
    
try:
    ast = parse_verilog(open(mvpath).read())
except:
    print("ERROR - parsing failed")
    traceback.print_exc()
    exit(-2)
    
"""
ast - has modules[] - one in the top level
mod=ast.modules[0]
mod has these fields:
modules[0].__dict__.keys()

['module_name', 'port_list', 'module_items', 'net_declarations', 'output_declarations', 'input_declarations', 'module_instances', 'assignments', 'sub_modules']

have 501 module_instances
say inst=mod.module_instances[0]
has module_name, instance_name, ports
"""

vpath=os.path.abspath(vpath)
vdir=os.path.dirname(vpath)
base=os.path.basename(vpath)

merged=vdir+"/merged_"+base
ostrm=open(merged,"w")

mainmod=ast.modules[0]
required_modules={}
spefs_needed=[]

for inst in mainmod.module_instances:
    modname=inst.module_name
    instname=inst.instance_name
    required_modules[modname]=1
    spefs_needed.append((modname,instname))

#now fetch the module verilog once per module master
ok=True
nmerged=0
for mod in required_modules.keys():
    modfile=vdir+"/"+mod+".v"
    if not os.path.isfile(modfile):
        print("missing file for %s\n"%mod)
        ok=False
    else:
        includeFile(modfile,ostrm)
        nmerged+=1
        
#include the main netlist
if ok:
    includeFile(vpath,ostrm)
    nmerged+=1
    
ostrm.close()
    
if not ok:
    print("above modules missing - cannot proceed")
    exit(-3)
else:
    print("Merged %d files into %s\n"%(nmerged,merged))

#create the spef loading script
spath=os.path.abspath(spath)
sdir=os.path.dirname(spath)
sbase=os.path.basename(spath)
pos=sbase.find(".")
stem=sbase[:pos]

sout=sdir+"/"+stem+".tcl"
ostrm=open(sout,"w")
ostrm.write("#file to include all the spefs needed for design %s\n"%base)
ostrm.write('puts ">>> reading top level spef %s"\n'%spath)
ostrm.write('read_spef %s\n'%spath)

ok=True
nspefs=0
for spefpair in spefs_needed:
    modname,instname=spefpair
    smod=sdir+"/"+modname+".spef"
    if not os.path.isfile(smod):
        print("missing spef for %s\n"%modname)
        ok=False
    else:
        ostrm.write('puts ">>> reading module spef %s"\n'%smod)
        ostrm.write('read_spef -path %s %s\n'%(instname,smod))
        nspefs+=1
        
ostrm.close()
if not ok:
    print("above modules missing spefs - cannot proceed\n")
    exit(-4)
else:
    print("read %d instance spefs in script %s\n"%(nspefs,sout))

#create the main script
alltcl=vdir+"/all_sta.tcl"
doexit="" if interactive else "exit"

ostrm=open(alltcl,"w")
ostrm.write("""
#script to do our STA of the design - including loading the spefs
puts ">>>STA start"

source $::env(SCRIPTS_DIR)/openroad/common/io.tcl
read_libs
#why is this in here?!
#read_lef $::env(MERGED_LEF)
puts ">>> about to read netlist"
read_netlist
puts ">>> read netlist"

if { $::env(STA_PRE_CTS) == 1 } {
    unset_propagated_clock [all_clocks]
} else {
    set_propagated_clock [all_clocks]
}

set_cmd_units -time ns -capacitance pF -current mA -voltage V -resistance kOhm -distance um

#run script to load all the parasitics
puts ">>> about to run spef loading script %s"
source %s

#report how well we have annotated
report_parasitic_annotation

#apply the constraints
puts ">>> load constraints %s"
source %s

#check the clocks
report_clock_properties [all_clocks]

#do the analysis
puts "min_report"
puts "\n==========================================================================="
puts "report_checks -path_delay min (Hold)"
puts "============================================================================"
report_checks -path_delay min -fields {slew cap input nets fanout} -format full_clock_expanded -group_count 5
puts "min_report_end"

puts "max_report"
puts "\n==========================================================================="
puts "report_checks -path_delay max (Setup)"
puts "============================================================================"
report_checks -path_delay max -fields {slew cap input nets fanout} -format full_clock_expanded -group_count 5
puts "max_report_end"


puts "check_report"
puts "\n==========================================================================="
puts "report_checks -unconstrained"
puts "============================================================================"
report_checks -unconstrained -fields {slew cap input nets fanout} -format full_clock_expanded

puts "\n==========================================================================="
puts "report_checks --slack_max -0.01"
puts "============================================================================"
report_checks -slack_max -0.01 -fields {slew cap input nets fanout} -format full_clock_expanded
puts "check_report_end"

puts "check_slew"
puts "\n==========================================================================="
puts " report_check_types -max_slew -max_cap -max_fanout -violators"
puts "============================================================================"
report_check_types -max_slew -max_capacitance -max_fanout -violators

%s
"""%(sout,sout,sdc,sdc,doexit))

ostrm.close()
print("wrote analysis script %s\n"%alltcl)

#write the script that invokes sta
shpath=vdir+"/sta.sh"
ostrm=open(shpath,"w")
ostrm.write("""
#!/bin/bash
#
# set up the environment for non-docker sta run similar to openlane runs
# usage ./sta.sh

# set up the environment
export DESIGN_NAME=%s
export openlane=$OPENLANE_ROOT
#openroad/OpenLane
export DESIGN_DIR=designs/$DESIGN_NAME

#bits from openlane we are not actually using here
#export DESIGN_CONFIG=$DESIGN_DIR/config.json
#export RUN_STANDALONE=1
#export CURRENT_ODB="0"
#export CURRENT_INDEX=1
#variables used in top level constraints
#SYNTH_MAX_FANOUT
#SYNTH_CLK_DRIVING_CELL
#SYNTH_CLK_DRIVING_CELL_PIN
#SYNTH_DRIVING_CELL
#SYNTH_DRIVING_CELL_PIN
#SYNTH_CAP_LOAD
#SYNTH_CLOCK_UNCERTAINTY
#SYNTH_CLOCK_TRANSITION
#SYNTH_TIMING_DERATE

export SCRIPTS_DIR=$openlane/scripts
#typ
#export LIB_SYNTH_COMPLETE=$PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
#slow
export LIB_SYNTH_COMPLETE=$PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__ss_100C_1v40.lib
#fast
#export LIB_SYNTH_COMPLETE=$PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__ff_n40C_1v95.lib

export STA_WRITE_LIB=0
#may want to change this?!
export STA_PRE_CTS=0

export CURRENT_NETLIST=%s

sta %s
"""%(stem,merged,alltcl))

ostrm.close()

print("wrote master script %s\n"%shpath)

#now actually invoke the run
print("running STA - %s\n"%shpath)
#os.system(". %s"%shpath)






