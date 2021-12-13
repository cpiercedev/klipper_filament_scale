#!/usr/bin/python
import sys
import re
import os
import argparse


# total arguments
sourceFile=sys.argv[1]
n = len(sys.argv)
print("Total arguments passed:", n)
 
weight=[]

with open(sourceFile, "r") as f:
    lines = f.readlines()

with open(sourceFile, 'r+') as f: #r+ does the work of rw
    lines = f.readlines()
    for i, line in enumerate(lines):
        if line.startswith('; filament used [g] = '):
            weight = lines[i].strip().replace('; filament used [g] =','').replace(',','').split()
            weight = [float(ele) for ele in weight]

            print(weight)
    f.seek(0)
    for line in lines:
        f.write(line)


with open(sourceFile, 'r+') as f: #r+ does the work of rw
    lines = f.readlines()
    for i, line in enumerate(lines):
        if line.startswith('PRINT_START'):
            print("found print start")
            lines[i] = lines[i].strip() + " WEIGHT=%s \n" % (weight)
    f.seek(0)
    for line in lines:
        f.write(line)