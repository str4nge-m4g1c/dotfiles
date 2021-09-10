* List commands that a user has access too
	* sudo -l
* Add a user
	* useradd USERNAME
* Set user password
	* passwd USERNAME
* Check user permission groups
	* groups
* delete a user
	* deluser --remove-all-files USERNAME
* Add user to the wheel
	* usermod -aG wheel USERNAME
* Restricting commands to the users
	* visudo
	* joe ALL=(ALL) NOPASSWD: /full/path/to/command ARG1 ARG2
* Check incidents and reports
	* tail /var/log/secure
* Set it so user/password does not expire
* Who is logged in
	* w
* What processes are running
	* ps -au | more
	* ps -au | less
* Add to SSH access
	* edit the "AllowGroups" in the /etc/ssh/sshd_config file
	* restart the service "service sshd restart"
* Give folder permissions
	* sudo chown -R glass_guide_user:glass_guide_user /iag/glass_data/
* Check password expiration
	* chage -l USERNAME
* To disable password aging / expiration for user foo, type command as follows and set:
	* Minimum Password Age to 0
	* Maximum Password Age to 99999
	* Password Inactive to -1
	* Account Expiration Date to -1
		* Interactive mode command:
			* chage USERNAME
		* OR
			* chage -I -1 -m 0 -M 99999 -E -1 USERNAME


MORE HELP:
https://www.linode.com/docs/tools-reference/linux-users-and-groups
http://www.tecmint.com/useful-linux-commands-for-system-administrators/

---

Mystery commands:
- df -BM d1


Host * !*.iag.com.au !*.auiag.corp !10.*.*.*
  229   ProxyCommand nc -X connect -x gopha.auiag.corp:8080 %h %p
  230   IdentityFile ~/.ssh/id_rsa
  231   ServerAliveInterval 60          
  232   ServerAliveCountMax 2

---


mysql -h localhost -u cattle --password=cattle

show global status like 'wsrep_cluster_status';

show status like 'wsrep_last_committed';


SET GLOBAL wsrep_provider_options='pc.bootstrap=YES';

---


Find size of files and name:
find /var/ -type d -name 'newrelic*' | xargs du -BM -d1

find /var/ -mtime -7 | xargs du -BM -d1

find /var/ -type f \( -not -path "*docker/*" \) -mtime -5 -print0 | du --files0-from=- -hc --block-size=1M

---
PACT Testing remove pact:

curl -XDELETE http://pmc71tst309:5000/pacts/provider/UWRulesApi/consumer/ReactFrontEnd/3.0.344
.
curl -X DELETE http://pmc71tst309:5000/pacticipants/UWRulesApi

---

WINDOWS:
Find and kill PID processes:
netstat -aonb > /d/logs/netstat.log
netstat -aonb | grep 8001
taskkill /F /PID 12345 

---
Copy from the remote server
scp -i ~/.ssh/cloud-user cloud-user@pmc71dev1897.auiag.corp:/iag/glass_data/*.zip .

---
Copy ssh key from local to remote server
ssh-copy-id -i .ssh/cloud-user cloud-user@pmc71dev2122.auiag.corp
---

Delete files older than 7 days:
find /folder/ -type f -name *.log -mtime +7 -print
find /folder/ -type f -name *.log -mtime +7 -delete

ansible -i inventory/ all -a "sudo find /iag/claims-policy-api/ -type f -name *.log -mtime +7
-print -delete" >> /vagrant/cleanup.log

---


1. Uptime Command

In Linux uptime command shows since how long your system is running and the number of users are currently logged in and also displays load average for 1,5 and 15 minutes intervals.
```
# uptime
08:16:26 up 22 min,  1 user,  load average: 0.00, 0.03, 0.22
```

Check Uptime Version

Uptime command don’t have other options other than uptime and version. It gives information only in hours:mins if it less than 1 day.
```
[tecmint@tecmint ~]$ uptime -V
procps version 3.2.8
```

2. W Command

It will displays users currently logged in and their process along-with shows load averages. also shows the login name, tty name, remote host, login time, idle time, JCPU, PCPU, command and processes.
```
# w
08:27:44 up 34 min,  1 user,  load average: 0.00, 0.00, 0.08
USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU WHAT
tecmint  pts/0    192.168.50.1     07:59    0.00s  0.29s  0.09s w
```

Available options

1. -h : displays no header entries.
2. -s : without JCPU and PCPU.
3. -f : Removes from field.
4. -V : (upper letter) – Shows versions.

3. Users Command

Users command displays currently logged in users. This command don’t have other parameters other than help and version.
```
# users
tecmint
```

4. Who Command

who command simply return user name, date, time and host information. who command is similar to w command. Unlikew command who doesn’t print what users are doing. Lets illustrate and see the different between who and w commands.
```
# who
tecmint  pts/0        2012-09-18 07:59 (192.168.50.1)
```
 
```
# w
08:43:58 up 50 min,  1 user,  load average: 0.64, 0.18, 0.06
USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU WHAT
tecmint  pts/0    192.168.50.1     07:59    0.00s  0.43s  0.10s w
```

Who command Options

1. -b : Displays last system reboot date and time.
2. -r : Shows current runlet.
3. -a, –all : Displays all information in cumulatively.

5. Whoami Command

whoami command print the name of current user. You can also use “who am i” command to display the current user. If you are logged in as a root using sudo command “whoami” command return root as current user. Use “who am i” command if you want to know the exact user logged in.
```
# whoami
tecmint
```

6. ls Command

ls command display list of files in human readable format.
```
# ls -l
total 114
dr-xr-xr-x.   2 root root  4096 Sep 18 08:46 bin
dr-xr-xr-x.   5 root root  1024 Sep  8 15:49 boot
```
Sort file as per last modified time.
```
# ls -ltr
total 40
-rw-r--r--. 1 root root  6546 Sep 17 18:42 install.log.syslog
-rw-r--r--. 1 root root 22435 Sep 17 18:45 install.log
-rw-------. 1 root root  1003 Sep 17 18:45 anaconda-ks.cfg
```
For more examples of ls command, please check out our article on 15 Basic ‘ls’ Command Examples in Linux.

7. Crontab Command

List schedule jobs for current user with crontab command and -l option.
```
# crontab -l
00 10 * * * /bin/ls >/ls.txt
```
Edit your crontab with -e option. In the below example will open schedule jobs in VI editor. Make a necessary changes and quit pressing :wq keys which saves the setting automatically.
```
# crontab -e
```
For more examples of Linux Cron Command, please read our earlier article on 11 Cron Scheduling Task Examples in Linux.

8. Less Command

less command allows quickly view file. You can page up and down. Press ‘q‘ to quit from less window.
```
# less install.log
Installing setup-2.8.14-10.el6.noarch
warning: setup-2.8.14-10.el6.noarch: Header V3 RSA/SHA256 Signature, key ID c105b9de: NOKEY
Installing filesystem-2.4.30-2.1.el6.i686
Installing ca-certificates-2010.63-3.el6.noarch
Installing xml-common-0.6.3-32.el6.noarch
Installing tzdata-2010l-1.el6.noarch
Installing iso-codes-3.16-2.el6.noarch
```

9. More Command

more command allows quickly view file and shows details in percentage. You can page up and down. Press ‘q‘ to quit out from more window.
```
# more install.log
Installing setup-2.8.14-10.el6.noarch
warning: setup-2.8.14-10.el6.noarch: Header V3 RSA/SHA256 Signature, key ID c105b9de: NOKEY
Installing filesystem-2.4.30-2.1.el6.i686
Installing ca-certificates-2010.63-3.el6.noarch
Installing xml-common-0.6.3-32.el6.noarch
Installing tzdata-2010l-1.el6.noarch
Installing iso-codes-3.16-2.el6.noarch
--More--(10%)
```

10. CP Command

Copy file from source to destination preserving same mode.
```
# cp -p fileA fileB
```
You will be prompted before overwrite to file.
```
# cp -i fileA fileB
```

11. MV Command

Rename fileA to fileB. -i options prompt before overwrite. Ask for confirmation if exist already.
```
# mv -i fileA fileB
```

12. Cat Command

cat command used to view multiple file at the same time.
```
# cat fileA fileB
```
You combine more and less command with cat command to view file contain if that doesn’t fit in single screen / page.
```
# cat install.log | less
# cat install.log | more
```
For more examples of Linux cat command read our article on 13 Basic Cat Command Examples in Linux.

13. Cd command (change directory)

with cd command (change directory) it will goes to fileA directory.
```
# cd /fileA
```

14. pwd command (print working directory)

pwd command return with present working directory.
```
# pwd
/root
```

15. Sort command

Sorting lines of text files in ascending order. with -r options will sort in descending order.
```
#sort fileA.txt
#sort -r fileA.txt
```

16. VI Command

Vi is a most popular text editor available most of the UNIX-like OS. Below examples open file in read only with -R option. Press ‘:q‘ to quit from vi window.
```
# vi -R /etc/shadows
```

17. SSH Command (Secure Shell)

SSH command is used to login into remote host. For example the below ssh command will connect to remote host (192.168.50.2) using user as narad.
```
# ssh narad@192.168.50.2
```
To check the version of ssh use option -V (uppercase) shows version of ssh.
```
# ssh -V
OpenSSH_5.3p1, OpenSSL 1.0.0-fips 29 Mar 2010
```

18. Ftp or sftp Command

ftp or sftp command is used to connect to remote ftp host. ftp is (file transfer protocol) and sftp is (secure file transfer protocol). For example the below commands will connect to ftp host (192.168.50.2).
```
# ftp 192.168.50.2
# sftp 192.168.50.2
```
Putting multiple files in remote host with mput similarly we can do mget to download multiple files from remote host.
```
# ftp > mput *.txt
# ftp > mget *.txt
```

19. Service Command

Service command call script located at /etc/init.d/ directory and execute the script. There are two ways to start the any service. For example we start the service called httpd with service command.
```
# service httpd start
OR
# /etc/init.d/httpd start
```

20. Free command

Free command shows free, total and swap memory information in bytes.
```
# free
total       used       free     shared    buffers     cached
Mem:       1030800     735944     294856          0      51648     547696
-/+ buffers/cache:     136600     894200
Swap:      2064376          0    2064376
```
Free with -t options shows total memory used and available to use in bytes.
```
# free -t
total       used       free     shared    buffers     cached
Mem:       1030800     736096     294704          0      51720     547704
-/+ buffers/cache:     136672     894128
Swap:      2064376          0    2064376
Total:     3095176     736096    2359080
```

21. Top Command

top command displays processor activity of your system and also displays tasks managed by kernel in real-time. It’ll showprocessor and memory are being used. Use top command with ‘u‘ option this will display specific User process details as shown below. Press ‘O‘ (uppercase letter) to sort as per desired by you. Press ‘q‘ to quit from top screen.
```
# top -u tecmint
top - 11:13:11 up  3:19,  2 users,  load average: 0.00, 0.00, 0.00
Tasks: 116 total,   1 running, 115 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.0%us,  0.3%sy,  0.0%ni, 99.7%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
Mem:   1030800k total,   736188k used,   294612k free,    51760k buffers
Swap:  2064376k total,        0k used,  2064376k free,   547704k cached
PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
1889 tecmint   20   0 11468 1648  920 S  0.0  0.2   0:00.59 sshd
1890 tecmint   20   0  5124 1668 1416 S  0.0  0.2   0:00.44 bash
6698 tecmint   20   0 11600 1668  924 S  0.0  0.2   0:01.19 sshd
6699 tecmint   20   0  5124 1596 1352 S  0.0  0.2   0:00.11 bash
```
For more about top command we’ve already compiled a list of 12 TOP Command Examples in Linux.

22. Tar Command

tar command is used to compress files and folders in Linux. For example the below command will create a archive for /homedirectory with file name as archive-name.tar.
```
# tar -cvf archive-name.tar /home
```
To extract tar archive file use the option as follows.
```
# tar -xvf archive-name.tar
```
To understand more about tar command we’ve created a complete how-to guide on tar command at 18 Tar Command Examples in Linux.

23. Grep Command

grep search for a given string in a file. Only tecmint user displays from /etc/passwd file. we can use -i option for ignoring case sensitive.
```
# grep tecmint /etc/passwd
tecmint:x:500:500::/home/tecmint:/bin/bash
```

24. Find Command

Find command used to search files, strings and directories. The below example of find command search tecmint word in ‘/‘ partition and return the output.
```
# find / -name tecmint
/var/spool/mail/tecmint
/home/tecmint
/root/home/tecmint
```
For complete guide on Linux find command examples fount at 35 Practical Examples of Linux Find Command.

25. lsof Command

lsof mean List of all open files. Below lsof command list of all opened files by user tecmint.
```
# lsof -u tecmint
COMMAND  PID    USER   FD   TYPE     DEVICE SIZE/OFF   NODE NAME
sshd    1889 tecmint  cwd    DIR      253,0     4096      2 /
sshd    1889 tecmint  txt    REG      253,0   532336 298069 /usr/sbin/sshd
sshd    1889 tecmint  DEL    REG      253,0          412940 /lib/libcom_err.so.2.1
sshd    1889 tecmint  DEL    REG      253,0          393156 /lib/ld-2.12.so
sshd    1889 tecmint  DEL    REG      253,0          298643 /usr/lib/libcrypto.so.1.0.0
sshd    1889 tecmint  DEL    REG      253,0          393173 /lib/libnsl-2.12.so
sshd    1889 tecmint  DEL    REG      253,0          412937 /lib/libkrb5support.so.0.1
sshd    1889 tecmint  DEL    REG      253,0          412961 /lib/libplc4.so
```
For more lsof command examples visit 10 lsof Command Examples in Linux.

26. last command

With last command we can watch user’s activity in the system. This command can execute normal user also. It will display complete user’s info like terminal, time, date, system reboot or boot and kernel version. Useful command to troubleshoot.
```
# last
tecmint  pts/1        192.168.50.1     Tue Sep 18 08:50   still logged in
tecmint  pts/0        192.168.50.1     Tue Sep 18 07:59   still logged in
reboot   system boot  2.6.32-279.el6.i Tue Sep 18 07:54 - 11:38  (03:43)
root     pts/1        192.168.50.1     Sun Sep 16 10:40 - down   (03:53)
root     pts/0        :0.0             Sun Sep 16 10:36 - 13:09  (02:32)
root     tty1         :0               Sun Sep 16 10:07 - down   (04:26)
reboot   system boot  2.6.32-279.el6.i Sun Sep 16 09:57 - 14:33  (04:35)
narad    pts/2        192.168.50.1     Thu Sep 13 08:07 - down   (01:15)
```
You can use last with username to know for specific user’s activity as shown below.
```
# last tecmint
tecmint  pts/1        192.168.50.1     Tue Sep 18 08:50   still logged in
tecmint  pts/0        192.168.50.1     Tue Sep 18 07:59   still logged in
tecmint  pts/1        192.168.50.1     Thu Sep 13 08:07 - down   (01:15)
tecmint  pts/4        192.168.50.1     Wed Sep 12 10:12 - 12:29  (02:17)
```

27. ps command

ps command displays about processes running in the system. Below example show init process only.
```
# ps -ef | grep init
root         1     0  0 07:53 ?        00:00:04 /sbin/init
root      7508  6825  0 11:48 pts/1    00:00:00 grep init
```

28. kill command

Use kill command to terminate process. First find process id with ps command as shown below and kill process with kill -9command.
```
# ps -ef | grep init
root         1     0  0 07:53 ?        00:00:04 /sbin/init
root      7508  6825  0 11:48 pts/1    00:00:00 grep init
# kill- 9 7508
```

29. rm command

rm command used to remove or delete a file without prompting for confirmation.
```
# rm filename
```
Using -i option to get confirmation before removing it. Using options ‘-r‘ and ‘-f‘ will remove the file forcefully without confirmation.
```
# rm -i test.txt
rm: remove regular file `test.txt'?
```

30. mkdir command example.

mkdir command is used to create directories under Linux.
```
# mkdir directoryname
```

This is a handy day to day useable basic commands in Linux / Unix-like operating system. Kindly share through our comment box if we missed out.


31. history command example.

history command is used to get the command history of the logged in user.
