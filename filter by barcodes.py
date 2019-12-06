# -*- coding: utf-8 -*-
#!/usr/bin/python
# by Yuhan Fei
from optparse import OptionParser

parser = OptionParser()
parser.add_option("-i", dest="infile", help="the name of input fastq file", metavar="FILE")
parser.add_option("-o", dest="outfile", help="the name of oufput fastq file", metavar="FILE")
(options, args) = parser.parse_args()


fqfile=file(options.infile,'r')
fqfilter=file(options.outfile,'w')


i=0
for line in fqfile:
		if i%4==0:
			seqID=line.strip("\n")
		elif i%4==1:
			sequence=line.strip("\n")
		elif i%4==2:
			mark=line.strip("\n")
		elif i%4==3:
				if sequence[0:4]=='AGCG' or sequence[0:4]=='CGTC':
					qual=line.strip("\n")
					fqfilter.write(seqID+"\n"+sequence+"\n"+mark+"\n"+qual+"\n")
		i+=1
fqfile.close()
fqfilter.close()