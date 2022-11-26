#!/bin/bash
set -e
#make compress
#gzip -fn --best *gds
git add -u .
git add gds/ lef/ verilog/gl/ verilog/rtl/
