#! /bin/bash

echo "Checking for chromium."
if [ ! $(which chromium) ]; then
    echo "Chromium not found. Please install using apt-get."
    exit 1
else
    echo "Chromium found."
fi

if [ ! -f "mon.sh" ] ; then
    echo "mon.sh not found. Exiting."
    exit 1
fi
if [ ! -f "start_cmstv.sh" ] ; then
    echo "start_cmstv.sh not found. Exiting."
    exit 1
fi

MONSH_CMD=$(readlink -e mon.sh)
CMSTV_CMD=$(readlink -e start_cmstv.sh)

crontab -l > mycron.tab

if grep -q "start_cmstv" mycron.tab
then
    echo "cmstv already found in user crontab. Crontab will not changed."
    exit 1
else
    echo "Appending cmstv scripts to crontab."
    echo "  0 8  *   *   1-5   ${MONSH_CMD} on" >> mycron.tab
    echo "  0 20 *   *   *     ${MONSH_CMD} off" >> mycron.tab
    echo "*/5 *  *   *   *     ${CMSTV_CMD} > /dev/null" >> mycron.tab
fi
echo "Installing new crontab file..."
crontab mycron.tab
rm mycron.tab

echo "Setting up autostart in LXDE."


if [ -f /etc/xdg/lxsession/LXDE-pi/autostart ] ; then
   
fi
