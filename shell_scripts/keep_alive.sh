#!/usr/bin/env bash

read -p "User: " USERNAME
read -s -p "Password: " PASSWORD

while :
do
    date +"%Y-%m-%d %H:%M:%S "; curl -s -o /dev/null -w "%{http_code}\n" --proxy-user ${USERNAME}:${PASSWORD} --proxy http://proxy.corp:8080 http://freshshiningoldmelody.neverssl.com/online/; sleep 15
done
