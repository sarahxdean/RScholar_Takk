#! /usr/bin/python
# written by Sarah Dean to work in conjunction with TakkTile code by Ian Daniher

import TakkTileread
import os.path
import sys, pprint

i = 1
while os.path.exists('dataruns/data'+ str(i)+ '.txt'):
	i+=1
name = 'dataruns/data'+str(i)+'.txt'
print name

ft = open('dataruns/temp'+str(i)+'.txt', 'w')
f = open(name, 'w')
s = '\t'.join('s'+str(num) for num in range(0,40))
f.write(s+'\ttime\n')
ft.write(s+'\ttime\n')
#print s

tact = TakkTileread.TakkTile()
try:
	count = int(sys.argv[1])
except:
	count = 5

import time
tact.startSampling(200)
start = time.time()

for i in range(count):
	dic, temp = tact.getData()
	s = '\t'.join(map(str,dic.values()))+'\t'+str(time.time()-start) #note: if one sensors is gone during sampling bad
	st = '\t'.join(map(str,temp.values()))+'\t'+str(time.time()-start) #note: if one sensors is gone during sampling bad
	print str(i)
	f.write(s+'\n')
	ft.write(st+'\n')
f.close()
ft.close()
#end = time.time()
tact.stopSampling()
print "done"                               
