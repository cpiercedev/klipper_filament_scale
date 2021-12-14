#!/usr/bin/python
import sys
import re
import os
import argparse


# total arguments
sourceFile=sys.argv[1]
n = len(sys.argv)
print("Total arguments passed:", n)
 
weight=""

with open(sourceFile, "r") as f:
    lines = f.readlines()

with open(sourceFile, 'r+') as f: #r+ does the work of rw
    lines = f.readlines()
    for i, line in enumerate(lines):
        if line.startswith('; filament used [g] = '):
            weight = lines[i].strip().replace('; filament used [g] = ','')

            print(weight)
    f.seek(0)
    for line in lines:
        f.write(line)


with open(sourceFile, 'r+') as f: #r+ does the work of rw
    lines = f.readlines()
    for i, line in enumerate(lines):
        if line.lower().startswith('print_start'):
            print("found print start")
            lines[i] = lines[i].strip() + " WEIGHTS=\"%s\" \n" % (weight)
    f.seek(0)
    for line in lines:
        f.write(line)