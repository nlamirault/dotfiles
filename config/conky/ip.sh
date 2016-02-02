#!/bin/bash
# voir ip derriere routeur
pingresult=$(ping -c 1 www.google.fr | grep received |cut -d "," -f2 | cut -d " " -f2)
error="Non connecté"
if [[ "$pingresult" == "ping: unknown host www.google.fr" ]]
then
    echo $error
else
    if [[ "$pingresult" == "1" ]]
    then
	wget http://checkip.dyndns.org/ -O - -o /dev/null | cut -d: -f 2 | cut -d\< -f 1 > $HOME/.conky/ip
    else
        echo $error
    fi
fi
