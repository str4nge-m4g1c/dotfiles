ansible -i inventory/preprod all -a "df" | grep 'SUCCESS\|/dev/mapper/datavg-lv_iag\|[7-9][0-9]%\|100%'

ansible-playbook -i 'cloud-user@pmc71dev2201.auiag.corp,' --key-file "~/.ssh/cloud-user" initial-box-setup.yml
