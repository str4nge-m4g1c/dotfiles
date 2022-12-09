#!/bin/sh

noProxy=localhost,127.0.0.1

echo "Choose a proxy: mycompany / local / dev / none"
read answer

if [[ ( $answer == "mycompany" ) ]]; then
    mycompanyProxyServer=http://proxy.corp:8080
    export http_proxy=$mycompanyProxyServer
    export https_proxy=$mycompanyProxyServer
    export no_proxy=$noProxy
    export HTTP_PROXY=$mycompanyProxyServer
    export HTTPS_PROXY=$mycompanyProxyServer
    export NO_PROXY=$noProxy
    echo "mycompany proxy enabled on: $mycompanyProxyServer"
elif [[ ( $answer == "local" ) ]]; then
    localProxyServer=http://localhost:3128
    export http_proxy=$localProxyServer
    export https_proxy=$localProxyServer
    export no_proxy=$noProxy
    export HTTP_PROXY=$localProxyServer
    export HTTPS_PROXY=$localProxyServer
    export NO_PROXY=$noProxy
    echo "local proxy enabled on: $localProxyServer"
elif [[ ( $answer == "dev" ) ]]; then
    echo "Enter username"
    read username
    echo "Enter password"
    read -s password
    devProxyServer=http://$username:$password@proxy.corp:8080
    export http_proxy=$devProxyServer
    export https_proxy=$devProxyServer
    export no_proxy=$noProxy
    export HTTP_PROXY=$devProxyServer
    export HTTPS_PROXY=$devProxyServer
    export NO_PROXY=$noProxy
    echo "proxy enabled on http://username:password@proxy.corp:8080 using the credentials provided"
elif [[ ( $answer == "none" ) ]]; then
    export http_proxy=
    export https_proxy=
    export no_proxy=
    export HTTP_PROXY=
    export HTTPS_PROXY=
    export NO_PROXY=
    echo "proxy environment variables have been nullified"
else
    echo "You need to enter a valid proxy"
fi
