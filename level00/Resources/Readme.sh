find / -user flag00 2>/dev/null
cat /usr/sbin/john
su flag00
getflag
su level01

# search files by criterias
# find / - поиск в корневой папке = поиск на всем компьютере
# 2>/dev/null will filter out the errors so that they will not be output to your console.
# -user — владелец: имя пользователя или UID. OUr user is flag00
# Если при поиске возникает ошибка (например — 
#нет доступа чтения из каталога) то вывод команды становится менее информативным. Перенаправьте вывод STDERR в /dev/null.
# https://www.dcode.fr/caesar-cipher
# answer - nottoohardhere