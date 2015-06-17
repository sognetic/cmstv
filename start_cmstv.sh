#!/bin/bash

PIDFILE="/tmp/cmstv.pid"
COMMAND="http://www-ekp.physik.uni-karlsruhe.de/~sieber/cmstv/start"
DISPLAY=":0"

if [ -e "${PIDFILE}" ] && (ps -u $(whoami) -opid= | grep -P "^\s*$(cat ${PIDFILE})$" &> /dev/null); then
  echo "Already running."
  exit 0
fi

echo "Starting CMS TV."
#midori -e Fullscreen -a "${COMMAND}"  &
chromium --noerrdialogs --kiosk "${COMMAND}" >/dev/null &

echo $! > "${PIDFILE}"
chmod 644 "${PIDFILE}"

# So something is in the logs...
exit 88


