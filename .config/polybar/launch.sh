#!/bin/bash
killall -q polybar
echo "---" >> /tmp/polybar1.log
polybar bar1 >>/tmp/polybar1.log 2>&1 &
echo "Polybar launched"
