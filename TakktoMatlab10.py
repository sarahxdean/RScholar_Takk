#! /usr/bin/python
# written by Sarah Dean to work in conjunction with TakkTile code by Ian Daniher

import TakkTileread
import sys, pprint

tact = TakkTileread.TakkTile()
tact.startSampling(200)

dic = [0] * 40 #assume 40 sensors
temp = [0] * 40
for i in range (1, 11):
  tdic, ttemp = tact.getData()
  for j in range(0,40): dic[j] += tdic[j]
  for j in range(0,40): temp[j] += ttemp[j]

#s = '\t'.join(map(str,dic.values()))+'\t'+'\t'.join(map(str,temp.values()))
#sys.stdout.write(s)
s = "\t".join(map(str,dic))+"\t"+"\t".join(map(str,temp))
sys.stdout.write(s)

tact.stopSampling()
