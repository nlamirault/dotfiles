#!/bin/bash
# -*- coding: UTF8 -*-

if [ $# -eq 0 ]; then
        echo "Usage: $0 <netctl profile>"
        exit 1
fi

sudo ip link set wlp3s0 down
sudo netctl start $1
