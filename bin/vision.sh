#!/bin/bash

CONF=${HOME}

PACKETBEAT="${HOME}/Apps/beats/packetbeat"
TOPBEAT="${HOME}/Apps/beats/topbeat"
TELEGRAF="${HOME}/bin/telegraf"

echo "Monitoring with Vision"
sudo ${PACKETBEAT} -c ${CONF}/etc/nimbus-packetbeat.yml &
sudo ${TOPBEAT} -c ${CONF}/etc/nimbus-topbeat.yml &
sudo ${TELEGRAF} -config ${CONF}/etc/nimbus-telegraf.conf &
echo "Done"

