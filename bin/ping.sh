#!/bin/bash

if sudo ping -c 1 -W 2 $1 > /dev/null;
then
	echo "1"
else
	echo "0"
fi
