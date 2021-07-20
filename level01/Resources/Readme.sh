find / -name 'passwd' 2>/dev/null
cat /etc/passwd | grep flag01

#42hDRfypTqqnw
# download https://download.openwall.net/pub/projects/john/contrib/macosx/
# move passwd file into host directory - look at your ip, port, directory
scp -P 5000 scp://level01@192.168.24.113/../../../etc/passwd /Users/kysgramo/snow-crash/level01/Resources
# crack it 
./john passwd --show
#passwd - abcdefg