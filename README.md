# snow-crash

Get getflag
scp -P 5000 level00@192.168.56.1:/bin/getflag .
level00

Levels:

	1. Шифр Цезаря
		a. Decoder with Caesar code
		b. nottoohardhere
		c. x24ti5gi3x0ol2eh4esiuxias
	2. Взлом пербором
		a.  42hDRfypTqqnw
		b. abcdefg
		c. scp -P 5000 level00@192.168.56.1:/../../../etc/passwd .
		d. JtR/run/john --show <(echo 42hDRfypTqqnw)
		e. #57. Получение паролей с помощью John the Ripper.
		f. Важно сначала запустить john без show, а потом уже с ним
	3. Сниффинг, просмотр сетевого трафика с помощью tshark
		a. Сниффинг - https://networkguru.ru/wireshark-perekhvat-paroley/
			i. сниффер — программа или устройство для перехвата и анализа сетевого трафика (своего и/или чужого).
		b. Это логи сетевого трафика, там видно что пользователь вводил пароль
		c. Открываем с помощью утилиты tshark
			i. https://habr.com/ru/company/selectel/blog/233837/
		d. tshark -r level02.pcap -z follow,tcp,hex,0
			i. r - read, z - статистика о захваченных пакетах
		e. Точки в код - это непечатные символы типа конца строки или удаления. В это прикол - три символа пользователь стер и написал новые
		f. F2av5il02puano7naaf6adaaf
		g. ft_waNDReL0L - flag 
		h. kooda2puivaav1idi4f57q8iq
	4. privilege escalation using SUID Permission
		a. Файл с атрибутом setuid повышает права до пользователя-владельца файла (обычно root) в рамках запущенного процесса.  С его разрешением можно просматривать пароли
			i. https://www.hackingarticles.in/linux-privilege-escalation-using-suid-binaries/
			ii. -rwsr-sr-x
			iii. 
		b. Ltrace  - debugging utility, trace Linux system calls.
		c. Echo could be used for privilege escalation 
			i. Прога вызывает echo по относительному пути 
			ii. Мы созддим свой echo в своей папке =
		d. Программы линуска автоматически распредлеяются по типу в соотвествующие папки. Это позволяет не прописывать ее путь при исполнении. Переменная PATH рассказывает ОС где искать программу. В ней через : перечислены все папки и ОС ищет в них по очереди
			i. Увидеть все папки 
			echo $PATH
			ii. чтобы добавить новый путь к переменной PATH, можно воспользоваться командой export.
			export PATH=/tmp:$PATH - добавим в начало
		e. qi0maab88jeaj46qoumi7maus
	5. MITM атака с подменой трафика.
		a. Прога имеет setuid  расширение, берет некий х с какого-то порта и выдает его через echo 
		b. Каждое приложение принимает данные через определенные порты. Если приложение запущено и готово подключится к порту (принимать от него команды и реагировать на них) то оно "слушает" порт. Проверяем слушается ли 4747
			P адрес - это общий номер телефона, а порт - добавочный к нему номер. .
			То, что приложение "слушает" - означает, что у нужного вам человека есть отдельный дополнительный номер и он "сидит" возле него. вы ему позвонили, он поднял трубку и сказал "Алло"
		c. curl localhost:4747?x=\`getflag\`
	6. Подмена файла с помощью cron
		a. Cron ходит по папке каждые 5 сек, запускает все бинарники в нем и удаляет 
		b. this will put a file into the /opt/openarenaserver wait 3min to be sure, print it
	7. Уязвимость \е модификатора регулярок в preg_replace
		a. https://stackoverflow.com/questions/16986331/can-someone-explain-the-e-regex-modifier
		b. С помощью этого модификатора можно получить доступ ко всем паролям
	8. Замена LOGNAME
	9. Бинарник не принимает строки, но может принять ссылку на него
	10. Дешифровка шифратора, зависящего от положения символа  в массиве 
		a. F3iji1ju5yuevaus41q1afiuq
		b. s5cAJpM8ev6XHw998pRWG728z
	11. Циклическая подмена файла
		a. Бинарник посылает файл на хост при наличии прав. На бинарник есть права, на токен - нет
		b. Для проверки исползуется функция access(). У нее есть уязвимость: есть промежуток между проверкой прав и открытием файла, в этот промежуток можно подменить файлы. 
		c. Делаем одну ссылку на оба файла, отправляем эту ссылку на сервер, слушаем этот порт
		d. nc -l 6969 - прослушивать этот порт 
		e. Woupa2yuojeeaaed06riuj63c
		f. Feulo4b72j7edeahuete3no7c
	12. Popen command injection
		a. https://medium.com/hackernoon/10-common-security-gotchas-in-python-and-how-to-avoid-them-e19fbe265e03
		b. popen - создает новый процесс, в коде - echo процесс, туда и вводим иньекцию
		c. nc -zv localhost 5151 - сканирование порта
		d. nc host port - создание TCP-подключения
		e. fa6v5ateaw21peobuub8ipe6s
	13. Unprotected egrep
		a. egrep = grep -E, -E option enables usage of extended regexp patterns. This allows use of meta-symbols such as +, ? or |
		b. g1qKMiRpXf53AWhDaU7FEkczr 
	14. Fooling getuid using gdb
		a. Find comparison operation
			i. 0x0804859a <+14>:    cmp    $0x1092,%eax - smth compared with smth stored in eax
		b. Внутри gdb подменяем регистр на нужный нам 4242
		c. 2A31L79asukciNyi8uppkEuSx
	15. Breaking getflag
		a.  0x0804898e <+72>:    test   %eax,%eax
		c. jump *0x08048de5
		d. 7QiHafiNa3HVozsaXkawuYrTstxbpABHD8CPnHJ

		
Метод решения с дизассемблированием
Ida - анализатор бинарных файлов. С дизассемблированием и графом системных вызовов

Get getflag
scp -P 5000 level00@192.168.56.1:/bin/getflag .
level00

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

