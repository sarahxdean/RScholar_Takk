#! /usr/bin/python
# written by Sarah Dean to work in conjunction with TakkTile code by Ian Daniher

import TakkTileread
import os.path
import sys, pprint

i = 1
while os.path.exists('data'+ str(i)+ '.txt'):
	i+=1
name = 'data'+str(i)+'.txt'

f = open(name, 'w')
s = '\t'.join('s'+str(num) for num in range(0,40))
f.write(s+'\ttime\n')
print s

tact = TakkTileread.TakkTile()
try:
	count = int(sys.argv[1])
except:
	count = 5

import time
tact.startSampling(200)
start = time.time()

for i in range(count):
	dic = tact.getData()
	s = '\t'.join(map(str,dic.values()))+'\t'+str(time.time()-start) #note: if one sensors is gone during sampling bad
	print s
	f.write(s+'\n')
f.close()
#end = time.time()
tact.stopSampling()
                                    
