#!/usr/bin/python
import sys
import re
import os
import argparse


# total arguments
sourceFile=sys.argv[1]
weight = sourceFile.partition("weight_")[2].replace(".gcode", '').replace("g",'')
n = len(sys.argv)
print("Total arguments passed:", n)
 

 
 # Read the ENTIRE g-code file into memory
with open(sourceFile, "r") as f:
    lines = f.readlines()

with open(sourceFile, 'r+') as f: #r+ does the work of rw
    lines = f.readlines()
    for i, line in enumerate(lines):
        if line.startswith('print_start'):
            lines[i] = lines[i].strip() + " WEIGHT=%s \n" % (weight)
    f.seek(0)
    for line in lines:
        f.write(line)