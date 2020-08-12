#!/bin/sh

./.config/i3/lock.sh &
sleep 1s

systemctl suspend
