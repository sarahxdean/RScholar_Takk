#! /usr/bin/python
# written by Sarah Dean to work in conjunction with TakkTile code by Ian Daniher

import TakkTileread
import sys, pprint

def TakktoC():
	tact = TakkTileread.TakkTile()
	tact.startSampling(200)

	dic, temp = tact.getData()
	s = '\t'.join(map(str,dic.values()))+'\t'+'\t'.join(map(str,temp.values())) 

	sys.stdout.write(s)

	tact.stopSampling()
