# MyTools

* Install Ubuntu 18.04 Desktop
* Install Guest Additions
* Install ansible
* Run my_install.yml ansible playbook


VM on VPN issue
https://superuser.com/questions/1062200/use-host-vpn-in-guest-vm
Open an admin console on your windows7 host and execute the following:
$ VBoxManage list vms 
$ VBoxManage modifyvm --natdnshostresolver1 on
