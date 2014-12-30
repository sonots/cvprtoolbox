# Generate Contents.m 
# python cvprtoolbox.py > Contents.m
import glob;

print '%CVPR Toolbox (Computer Vision and Pattern Recognition Toolbox)'
files = glob.glob('*.m')
for file in files:
    f = open(file, 'r')
    lines = f.readlines()
    start = -1
    end = 0
    for (i, line) in enumerate(lines):
        line = line.strip()
        if start == -1:
            if line[0] == '%':
                start = i
        else:
            if line[0] != '%':
                break
            elif line == '%' or line == '' or line.find('SYNOPSIS') != -1:
                end = i
                break
    f.close()
    for line in lines[start:end]:
        print line.strip()

#print "addpath(pwd);"
#print "addpath([pwd, filesep, 'others']);"

