# matrix

Hello,

I send 5 files as attachments
1. matrix.service - the RHEL service file for point 2.4
2. ip_validation.sh - the bash script for points 2
3. info - the info file as input file with local IP address for bash or python scripts
4. info-multipleIPs  - the info file with multiple IP addresses good or wrong. This script test ip_validation.sh script
5. matrix - the python script for tasks 3.1 and 3.2

I completed tasks:
1 - done
2.1. - done
2.2. - done
3.1. - done
3.2. - done
3.3. - pending. So far I haven't known how to start IP checking based on GET requests. 
4. - done
5. - pending (this task is not possible to complete on CS50 sandbox linux. It's my son's linux and I didn't know that I am not able to install new rpmdevtools rpmlint packages). I will try to move these resources to AWS or maybe check linux config and download some packages or update repos.
Creating the RPM package is not very complicated.
 
You have to run some tasks before checking my job.
The resources deployed by me in the /root directory or /etc/systemd/system or /usr/bin files are regularly deleted :)

So tasks:
1. Copy all scripts and files and reload systemd service.
- matrix.service
- ip_validation.sh
- info
- info-multipleIPs
2. The matrix.py python script in in the /home/sandbox home directory.

Copy files/enable the services

$ cp -v matrix.service /etc/systemd/system/
'matrix.service' -> '/etc/systemd/system/matrix.service'

$ cp -v ip_validation.sh /usr/bin/
'ip_validation.sh' -> '/usr/bin/ip_validation.sh'

$ systemctl daemon-reload

$ systemctl enable --now matrix.service
Created symlink /etc/systemd/system/multi-user.target.wants/matrix.service → /etc/systemd/system/matrix.service.

$ cp -v info /root/
'info' -> '/root/info''
OR

$ cp -v info-validationIPs /root/
'info-validationIPs' -> '/root/info-validationIPs'

$ chmod 755 /usr/bin/ip_validation.sh 

The default /root/sandbox directory has two files: info and info-multipleIPs. First is with only one local IP address. Second is with multiple good/wrong IPs. You can test the bash script.
$ cp -v info-multipleIPs /root/info

cp: overwrite '/root/info'? y
'info-multipleIPs' -> '/root/info'

$ systemctl stop matrix.service

$ systemctl start matrix.service
Job for matrix.service failed because the control process exited with error code.
See "systemctl status matrix.service" and "journalctl -xe" for details.

$ systemctl status matrix.service
● matrix.service - Matrix service
   Loaded: loaded (/etc/systemd/system/matrix.service; enabled; vendor preset: enabled)
   Active: failed (Result: exit-code) since Fri 2022-04-15 10:31:29 UTC; 6s ago
  Process: 2042 ExecStart=/usr/bin/python3 /root/sandbox/matrix.py (code=killed, signal=TERM)
  Process: 2152 ExecStartPre=/usr/bin/ip_validation.sh (code=exited, status=1/FAILURE)
 Main PID: 2042 (code=killed, signal=TERM)

Apr 15 10:31:29 sound-bongo-w1ny systemd[1]: matrix.service: Control process exited, code=exited status=1
Apr 15 10:31:29 sound-bongo-w1ny systemd[1]: matrix.service: Failed with result 'exit-code'.
Apr 15 10:31:29 sound-bongo-w1ny systemd[1]: Failed to start Matrix service.
Apr 15 10:31:29 sound-bongo-w1ny systemd[1]: matrix.service: Service hold-off time over, scheduling restart.

The script failed because the bash script found the wrong IP address:

$ ./ip_validation.sh
1. Checking port server range.
Port server 6789 is valid -> the port range is 1-61000.
2. Validation IP addresses.
IP address 8.8.8.8 is a valid IP address.
IP address 8.8.4.4 is a valid IP address.
IP address 192.168.128.1 is a valid IP address.
Sorry, IP address a.1.1.1 is not a valid IP address. Exit

Good luck :)
