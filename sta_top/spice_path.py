#!/usr/bin/python3
usage="""spice_path.py <out>
write out critical path spice file
run this in /home/jeremy/openroad/OpenLane/pdks/sky130A/libs.tech/ngspice

( /usr/local/bin/ngspice path.spice )
 
then do
tran 1n 300n
plot i0 i50 i100 i150 i200 i250
"""

import os
import sys
import traceback

print(sys.argv)
    
if len(sys.argv)!=2:
    print("ERROR - "+usage)
    exit(-1)

script,opath=sys.argv

STAGES=250
CORNER="tt"

ostrm=open(opath,"w")
ostrm.write("""*critical path sim
* Typical corner (%s)
.param mc_mm_switch=0
.param mc_pr_switch=0
* MOSFET
.include "corners/%s.spice"
* Resistor/Capacitor
.include "r+c/res_typical__cap_typical.spice"
.include "r+c/res_typical__cap_typical__lin.spice"
* Special cells
.include "corners/%s/specialized_cells.spice"

*cells we are using in the path
.subckt sky130_fd_sc_hd__clkbuf_2 A VGND VNB VPB VPWR X
X0 a_27_47# A VPWR VPB sky130_fd_pr__pfet_01v8_hvt w=1e+06u l=150000u
X1 a_27_47# A VGND VNB sky130_fd_pr__nfet_01v8 w=420000u l=150000u
X2 X a_27_47# VPWR VPB sky130_fd_pr__pfet_01v8_hvt w=1e+06u l=150000u
X3 VPWR a_27_47# X VPB sky130_fd_pr__pfet_01v8_hvt w=1e+06u l=150000u
X4 X a_27_47# VGND VNB sky130_fd_pr__nfet_01v8 w=420000u l=150000u
X5 VGND a_27_47# X VNB sky130_fd_pr__nfet_01v8 w=420000u l=150000u
.ends


.subckt sky130_fd_sc_hd__buf_4 A VGND VNB VPB VPWR X
X0 X a_27_47# VGND VNB sky130_fd_pr__nfet_01v8 w=650000u l=150000u
X1 VGND a_27_47# X VNB sky130_fd_pr__nfet_01v8 w=650000u l=150000u
X2 X a_27_47# VGND VNB sky130_fd_pr__nfet_01v8 w=650000u l=150000u
X3 VGND a_27_47# X VNB sky130_fd_pr__nfet_01v8 w=650000u l=150000u
X4 X a_27_47# VPWR VPB sky130_fd_pr__pfet_01v8_hvt w=1e+06u l=150000u
X5 a_27_47# A VGND VNB sky130_fd_pr__nfet_01v8 w=650000u l=150000u
X6 X a_27_47# VPWR VPB sky130_fd_pr__pfet_01v8_hvt w=1e+06u l=150000u
X7 a_27_47# A VPWR VPB sky130_fd_pr__pfet_01v8_hvt w=1e+06u l=150000u
X8 VPWR a_27_47# X VPB sky130_fd_pr__pfet_01v8_hvt w=1e+06u l=150000u
X9 VPWR a_27_47# X VPB sky130_fd_pr__pfet_01v8_hvt w=1e+06u l=150000u
.ends

.subckt sky130_fd_sc_hd__clkinv_2 A VGND VNB VPB VPWR Y
X0 Y A VPWR VPB sky130_fd_pr__pfet_01v8_hvt w=1e+06u l=150000u
X1 VPWR A Y VPB sky130_fd_pr__pfet_01v8_hvt w=1e+06u l=150000u
X2 Y A VPWR VPB sky130_fd_pr__pfet_01v8_hvt w=1e+06u l=150000u
X3 VGND A Y VNB sky130_fd_pr__nfet_01v8 w=420000u l=150000u
X4 Y A VGND VNB sky130_fd_pr__nfet_01v8 w=420000u l=150000u
.ends

.subckt sky130_fd_sc_hd__clkinv_4 A VGND VNB VPB VPWR Y
X0 VPWR A Y VPB sky130_fd_pr__pfet_01v8_hvt w=1e+06u l=150000u
X1 Y A VPWR VPB sky130_fd_pr__pfet_01v8_hvt w=1e+06u l=150000u
X2 VGND A Y VNB sky130_fd_pr__nfet_01v8 w=420000u l=150000u
X3 Y A VGND VNB sky130_fd_pr__nfet_01v8 w=420000u l=150000u
X4 VGND A Y VNB sky130_fd_pr__nfet_01v8 w=420000u l=150000u
X5 VPWR A Y VPB sky130_fd_pr__pfet_01v8_hvt w=1e+06u l=150000u
X6 Y A VGND VNB sky130_fd_pr__nfet_01v8 w=420000u l=150000u
X7 Y A VPWR VPB sky130_fd_pr__pfet_01v8_hvt w=1e+06u l=150000u
X8 Y A VPWR VPB sky130_fd_pr__pfet_01v8_hvt w=1e+06u l=150000u
X9 VPWR A Y VPB sky130_fd_pr__pfet_01v8_hvt w=1e+06u l=150000u
.ends

*start of circuit
.title scanclk

*input stimulus
vs 1 0 dc 1.8
*             v1 v2 TD TR   TF PW   PER
* v1 = base voltage
* v2 = peak voltage
* TD = time to start of rise
* TR = rise time
* TF = fall time
* PW = pulse width
* PER = period
vi i0 0 PULSE(0 1.8 5n 1n 1n 10n 100n) 
"""%(CORNER,CORNER,CORNER))

invert=True
v=False

for i in range(STAGES):
    if 1:
        #old scheme
        #clkbuf2
        ostrm.write("xa%d i%d 0 0 1 1 m%d sky130_fd_sc_hd__clkbuf_2\n"%(i,i,i))
        #ostrm.write("xa%d i%d 0 0 1 1 m%d sky130_fd_sc_hd__clkinv_2\n"%(i,i,i))
        #pi network
        ostrm.write("cma%d m%d 0 0.00108P\n"%(i,i))
        ostrm.write("rm%d m%d n%d 43\n"%(i,i,i))
        ostrm.write("cmb%d n%d 0 0.00108P\n"%(i,i))
        #buf4
        ostrm.write("xb%d n%d 0 0 1 1 p%d sky130_fd_sc_hd__buf_4\n"%(i,i,i))
        #estimated pi
        ostrm.write("cpa%d p%d 0 0.0038P\n"%(i,i))
        ostrm.write("rp%d p%d i%d 33\n"%(i,i,i+1))
        ostrm.write("cpb%d i%d 0 0.0038P\n"%(i,i+1))
        a = 1.8 if v else 0.0
        ostrm.write(".ic v(m%d)=%d v(n%d)=%d v(p%d)=%d v(i%d)=%d\n"%(i,a,i,a,i,a,i,a))
    else:
        #new toggling scheme

        #input pi network
        ostrm.write("cia%d i%d 0 0.0047P\n"%(i,i))
        ostrm.write("ri%d i%d p%d 110.7\n"%(i,i,i))
        ostrm.write("cib%d p%d 0 0.0047P\n"%(i,i))

        #clkinv4
        ostrm.write("xa%d p%d 0 0 1 1 m%d sky130_fd_sc_hd__clkinv_4\n"%(i,i,i))
        #clkinv2 load
        ostrm.write("xb%d n%d 0 0 1 1 r%d sky130_fd_sc_hd__clkinv_2\n"%(i,i,i))

        #output pi network
        ostrm.write("cma%d m%d 0 0.0047P\n"%(i,i))
        ostrm.write("rm%d m%d i%d 110.7\n"%(i,i,i+1))
        ostrm.write("cmb%d i%d 0 0.0047P\n"%(i,i+1))

        a = 1.8 if v else 0.0
        b = (1.8-a) if invert else a

        ostrm.write(".ic v(i%d)=%d v(p%d)=%d v(m%d)=%d\n"%(i,a,i,a,i,b))
    
    if invert:
        v=not v
    
#do these work here?
#ostrm.write(".tran 1n 70n\n")
#ostrm.write(".plot i0 i50 i100 i150 i200 i250\n")

ostrm.write(".end\n")

ostrm.close()

