# cipher changing letter with n+1 step
import sys

for i, val in enumerate(sys.argv[1]):
    a = ord(val)
    if a > 6000:
    	a = a - 61440 #130
    sys.stdout.write(chr(a-i))
 	#print((ord(val))
