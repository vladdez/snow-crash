# snow-crash

short statistics of 15 attacks: 
- Man in The Middle file spoofing: 5
- cipher cracking: 3
- code injection: 3
- binary analysis: 2
- cyclical file spoofing : 1
- password sniffing: 1

# Levels:

## 0.
- attack: cipher cracking  
- utility: https://www.dcode.fr/caesar- cipher 
- hint: flag00, Intra video

## 1.
- attack: cipher cracking  
- vulnerability: unhashed DES (data encrypthion standart) password for flag01 in /etc/passwd
- utility: john 
- hint: /usr/sbin/john from previous level

## 2.
- attack: password sniffing (trafic analysis) 
- untilies: wireshark, tcpdump
- method: read TCP-data in IP packet
- hint: .nmap file, Intra video

## 3.
- attack: MITM file spoofing
- vulnerability1: SUID permission excalation 
- vulnerability2: relative path for echo  
- method: add new path to PATH, alias getflag as echo, use getflag intead of echo
- exploited function: system, echo
- used functions: export 
- hint: system("/usr/bin/env echo Exploit me"Exploit me

## 4.
- attack: MITM file spoofing
- vulnerability: SUID permission excalation
- method: HTML link injection via netcat request
- exploited function: ``, echo
- used functions1: netstat - lt, curl
- used functions2: nc (GET)
- hint: CGI

## 5.
- attack: MITM file spoofing
- vulnerability: SUID permission excalation
- exploited function: cron
- method: alias getflag in the target folder
- hint: cronfile in mail

## 6.
- attack: code injection
- vulnerability: string interpolation in PHP "$x"
- exploited functions: preg_replace with \e pattern modifier
- used functions: echo, exec
- additional language: PHP

## 7.
- attack: MITM file spoofing
- vulnerability: SUID permission excalation
- exploited functions: system
- method: changing environmental variable LOGNAME
- used functions: export

## 8.
- attack: MITM file spoofing
- vulnerability: SUID permission excalation
- defence: you can no put arguments with the name token - strstr("token", "token")
- method: soft link with other name to argument token
- used functions: ln

## 9.
- attack: cipher cracking  
- method: n+1 step decoder
- untility: python custom code

## 10.
- attack: cyclical file spoofing (race conditions)
- exploited function: access, open
- vulnerability: delay between using of access (check privelegies) and open
- method: two loops in different windows where one file pass access, and other file pass open
- used functions: ln - sf, nc - l

## 11.
- attack: code injection
- method: through localhost?
- vulnerability 1: string interpolation in lua ".. x .."
- vulnerability 2: SUID permission excalation
- exploited functions: popen, echo
- additional language: lua

## 12.
- attack: code injection
- vulnerability 1: string interpolation in perl "$x"
- vulnerability 2: SUID permission excalation
- additional language: perl
- used functions: curl
- method: inject a command using localhost, but use regex as argument to pass through defence inside the code
- defence: lowercase to uppercase, more than one letter

## 13.
- attack: binary analysis
- hint: ./ltrace ./level13 -  we expected 4242
- exploited function: getuid, cmp
- method: find register with user id and change it to the id of the user with higher rights
- used functions: gdb (disass, r, set,  c)
- hint: 

## 14.
- attack: binary analysis
- defence: ptrace -  with any use of gdb outputs an error
- exploited function: getuid, test, ptrace
- used functions: gdb (disass, r, n, info register/print, set,  c)
- method: change resigters for ptrace and getuids results

# Hacking all passwords

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

