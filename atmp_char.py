#http://stackoverflow.com/questions/9105990/constantly-looking-for-user-input-in-python

import TakkTileread
import os.path
import sys, pprint
import threading
import Queue

def console(q, lock):
	while 1:
		raw_input()
		with lock:
			cmd = raw_input('> ')
		q.put(cmd)
		if cmd == 'quit':
			break

def action_sample(lock):
	with lock:
		print('--> sampling')
	#while (1):
		#self.dic, self.temp = tact.getData()
	#	print('sampling')

def action_save(lock):
	with lock:
		print('--> recording data')
		#st = '\t'.join(map(str,dic.values()))+'\t'+'\t'.join(map(str,temp.values()))	
		st = 'example line of data' 
		force = raw_input('enter force: ')
		sensor = raw_input('enter sensor number: ')
		f.write(st+'\t'+force+'\t'+sensor+'\n')

def invalid_input(lock):
	with lock:
		print('--> unknown command')

def main(): 
	i = 1
	while os.path.exists('char/run'+str(i)+'.txt'):
		i+=1;
	name = 'char/run'+str(i)+'.txt'
	print name

	f = open(name, 'w')
	s = '\t'.join('s'+str(num) for num in range(1,41))+'\t'+'\t'.join('t'+str(num) for num in range(1,41))
	f.write(s+'\tF\ts\n')

	#tact = TakkTileread.TakkTile()
	#tact.startSampling(200)
	
	cmd_actions = {'sample': action_sample, 'save': action_save}
	cmd_queue = Queue.Queue()
	stdout_lock = threading.Lock()

	dj = threading.Thread(target=console, args=(cmd_queue, stdout_lock))
	dj.start()

	while 1:
		cmd = cmd_queue.get()
		if cmd == 'quit':
			f.close()
			break
		action = cmd_actions.get(cmd, invalid_input)
		action(stdout_lock)

		
main()
#connect to sensors

#loop reading data (and displaying)
#when 'r' is pressed, save that dataline
#ask for input force
#ask for input sensor number
#write dataline and inputs to file
#loop

#when q is pressed save file and then end
