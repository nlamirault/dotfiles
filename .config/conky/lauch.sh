#!/bin/bash

CONKY_HOME=$HOME/.config/conky

sleep 5
killall conky
sleep 2

cd $CONKY_HOME

conky -c $CONKY_HOME/conkyrc1 &
sleep 2
conky -c $CONKY_HOME/conkyrc2 &
sleep 2
