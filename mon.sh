#!/bin/bash

export DISPLAY=:0.0

if [ $# -eq 0 ]; then
  echo usage: $(basename $0) "on|off|status"
  exit 1
fi

if [ $1 = "off" ]; then
  echo -e "Enabling DPMS and blanking..."
  xset +dpms
  xset s on
  echo -e "Turning monitor off..."
  xset dpms force off
  echo -e "Powering down HDMI devices...."
  /opt/vc/bin/tvservice --off
  echo -en "done.\nCheck:"
  xset -q|grep "Monitor is"
elif [ $1 = "on" ]; then
  echo -e "Turning monitor on..."
  echo -e "Powering on HDMI devices..."
  /opt/vc/bin/tvservice --preferred
  sleep 5
  echo -e "Prevent screen from blanking..."
  xset s noblank
  xset s off
  echo -e "Force Monitor on."
  xset dpms force on
  echo -en "done.\nCheck:"
  xset -q|grep "Monitor is"
  echo -e "Disable DPMS completely."
  xset -dpms
elif [ $1 = "status" ]; then
  xset -q|sed -ne 's/^[ ]*Monitor is //p'
else 
  echo usage: $(basename $0) "on|off|status"
fi
