#http://stackoverflow.com/questions/9105990/constantly-looking-for-user-input-in-python

import TakkTileread
import os.path
import sys, pprint

i = 1
while os.path.exists('char/run'+str(i)+'.txt'):
	i+=1;
name = 'char/run'+str(i)+'.txt'
print name

f = open(name, 'w')
s = '\t'.join('s'+str(num) for num in range(1,41))+'\t'+'\t'.join('t'+str(num) for num in range(1,41))
f.write(s+'\tF\ts\n')

tact = TakkTileread.TakkTile()
tact.startSampling(200)

tact.getData()

for i in range(10000):
	c = input('> ')
	if c == 'quit':
		f.close()
		tact.stopSampling()
		break
	else:
		dic, temp = tact.getData()
		st = '\t'.join(map(str,dic.values()))+'\t'+'\t'.join(map(str,temp.values()))	
		print(st)
		force = str(input('enter force: '))
		sensor = str(input('enter sensor number: '))
		f.write(st+'\t'+force+'\t'+sensor+'\n')





		
#connect to sensors

#loop reading data (and displaying)
#when 'r' is pressed, save that dataline
#ask for input force
#ask for input sensor number
#write dataline and inputs to file
#loop

#when q is pressed save file and then end
