# snow-crash

Levels:
0.
# attack: cipher cracking  
# utility: https://www.dcode.fr/caesar-cipher 
# hint: 

1.
# attack: cipher cracking  
# vulnerability: unprotected DES password hash for flag01 in /etc/passwd
# utility: john 
# hint: /usr/sbin/john from previous level

2.
# attack: password sniffing (trafic analysis) 
# untilies: wireshark
# hint: 43 packet in nmap file

3.
# attack: MITM file spoofing
# vulnerability: SUID permission excalation  
# method: adding new path to PATH
# used functions: export, echo

4.
# attack: MITM file spoofing
# vulnerability: SUID permission excalation, commmon gateway interface
# used functions: netstat -lt, curl

5.
# attack: MITM file spoofing
# vulnerability: cron file permission excalation
# hint: cronfile in mail

6.
# attack: code injection
# vulnerability: string interpolation in PHP "$x"
# exploited functions: preg_replace with \e modifier
# used functions: echo
# additional language: PHP

7.
# attack: MITM file spoofing?
# vulnerability: SUID permission excalation?
# method: changing environemntal variable LOGNAME
# used functions: export

8.
# attack: MITM file spoofing
# vulnerability: SUID permission excalation?
# method: same soft link for two files
# used functions: ln

9.
# attack: cipher cracking  
# method: n+1 step decoder
# untility: python custom code

10.
# attack: cyclical file spoofing 
# exploited function: access
# vulnerability: time between check and access
# method: two loops in different windows
# used functions: ln -sf, nc -l

11.
# attack: code injection
# method: through localhost?
# vulnerability: string interpolation in lua ".. x .."
# exploited functions: popen, echo
# additional language: lua

12.
# attack: code injection
# vulnerability: string interpolation in perl "$x"
# additional language: perl
# used functions: curl
# method: inject a command using localhost, but use regex as argument to pass through defence inside the code
# defence: lowercase to uppercase, more than one letter

13.
# attack: password spoofing during disassembling and debugging
# hint: ./ltrace ./level13 - we expected 4242
# exploited function: getuid, cmp
# method: find comparing register and change it
# used functions: gdb (disass, r, set,  c)

14.
# attack: password spoofing during disassembling and debugging
# defence: ptrace - blocks any attempt to change anything using gdb
# used functions: gdb (disass, r, n, info register/print, set,  c)

#########

Метод решения с дизассемблированием
Ida - анализатор бинарных файлов. С дизассемблированием и графом системных вызовов

Части ассемблера

	- _ptrace - системный вызов, проверяем его возвращаемое значение
		○ Проверяет подключился ли кто к отладчику gdb, чтобы не менял по ходу отладки значение переменных 
	- Eax - тип регистра, куда кладуться значения вызова ptrace
		○ Если туда положить ноль, то ptrace  будто бы не вызывался
	- _getuid - системный вызов, возвращает значение id пользователя 

Идея - бинарный файл выдает соответствующий токен флага в зависимости от того, какой пользователь к нему обращается

Алгос - меняем id пользователя который вернул системный вызов

	-  cat /etc/passwd
	- Описание пользователя в системе Линкс
		○ flag14:x:3014:3014::/home/flag/flag14:/bin/bash
		○ Имя/хешированный пароль/id пользователя/группа
	- gdb -q getflag
		○ Тихий режим
	- Ставим брейкопинты на вызовы
		b *main +72 - ломает защиту от подключения отладчика
			 0x0804898e <+72>:    test   %eax,%eax
		b *main +452 - чтобы писать нужного пользователя в регистр
			0x08048b0a <+452>:   cmp    $0xbbe,%eax
		r  - run
	- Перезапись регистра, который отвечает за запущенный id 
		print $eax - default -1
		c - continue 
		set $eax=3013
		c
	- Бинарник думает что мы зашли под нужным пользователем

