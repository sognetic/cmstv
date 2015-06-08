# Recent monitoring information from CERN

These pages are written to display newest displays and monitoring information from the current datataking period of the LHC at CERN.
It is intended for showcases. To use it, just open [start](start "Display") in a browser.

## Clone your own repository

If you want to adapt this setup to your needs, just copy this
folder to your webspace and work on it.
Feedback and improvements are always welcome. Please contact <joram.berger@kit.edu>.
This information is generated from `README.md` using

        markdown README.md > README.html

## Setup of Raspberry Pis as display stations

These steps lead you to a display station, based on a Raspberry Pie and a monitor, the

- Install `midori`, a lightweight browser with full screen mode accessible from the command line (others like `chromium` would also work):

        sudo apt-get install midori

- To start `midori` on boot and prevent the screen saver from showing up, add these lines to `/etc/xdg/lxsession/LXDE-pi/autostart`:

        @xset s noblank
        @midori -e Fullscreen -a http://www-ekp.physik.uni-karlsruhe.de/~berger/cmstv/start
  If the Raspberry Pi is not setup with NOOBS, the file is called `/etc/xdg/lxsession/LXDE/autostart`.

- To show the display only on working days from 7 a.m. to 8 p.m., add these lines to crontab (`crontab -e`):

        0  7 * * 1-5 /usr/bin/xset dpms force on
        0 20 * * *   /usr/bin/xset dpms force off

- If the screen resolution is not correct, these settings in `/boot/config.txt` might help:

        disable_overscan=1
        hdmi_group=1
        hdmi_mode=31
        # commment out all overscan_bottom or _top etc.

Now it should be ready after reboot (no further interaction needed):

        sudo reboot