#!/bin/sh

# this will insert and remove the following modules, waiting WAIT_TIME between:
MODULE_ONE="power-supply"
MODULE_TWO="gpio"

while :
do
    ${MODULE_ONE}
    sleep 2
    ${MODULE_TWO}
    sleep 2
done
