ansible -i inventory/prod all -a "df" | grep 'SUCCESS\|/dev/mapper/datavg-lv_company\|[7-9][0-9]%\|100%'

ansible-playbook -i 'some-user@somecompany.corp,' --key-file "~/.ssh/some-user" initial-box-setup.yml
