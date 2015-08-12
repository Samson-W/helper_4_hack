# -*- coding: utf-8 -*-
#!/usr/bin/python

#Description: 
#	This function is to generate a fixed length of the file, the unit is KB.

import os
import sys
import string

argc=len(sys.argv)
if argc < 2:
	print " usage method: ./Genfixedlenfile.py <number> "
	sys.exit()

count_k=string.atoi(sys.argv[1])

filename="fixfile_" + str(sys.argv[1])
file_obj=open(filename,'w')

for i in range(0, count_k):
	stri=str(i).zfill(10)
	filetext=stri + "j"*(1024-10-1)
	file_obj.write(filetext+'\n')

file_obj.close()
