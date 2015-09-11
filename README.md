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

These steps lead you to a display station, based on a Raspberry Pie and a monitor.

- Setup Raspbian on your Raspberry Pi using either NOOBS or the manual installation image.

- Install `chromium`, a stable browser with full screen mode accessible from the command line. Also
  install the Microsoft ttf fonts.:

        sudo apt-get install chromium ttf-mscorefonts-installer
        
- Clone the repository in your home folder:

        git clone https://github.com/JoramBerger/cmstv.git

- To start the display on boot and prevent the screen saver from showing up, add these lines to `/etc/xdg/lxsession/LXDE-pi/autostart`. You may have to adapt the paths to the working copy of 
the cloned respository:

        @/home/pi/cmstv/mon.sh on
        @/home/pi/cmstv/start_cmstv.sh

  If the Raspberry Pi is not setup with NOOBS, the file is called `/etc/xdg/lxsession/LXDE/autostart`.

  If the screen is blank after waking up, try adding the following setting to `/etc/rc.local`.

        # disable console blanking for CMS-TV usage
        setterm -blank 0 -powersave off -powerdown 0 

- To show the display only on working days from 7 a.m. to 8 p.m., add these lines to crontab (`crontab -e`). Again
  check that the paths point to the checked out version of the cmstv repository. The start_cmstv.sh script will
  startup the browser in kiosk mode and check every 5 minutes if the browser is still running. Midori e.g. had some
  stability issues after running for a couple of days:

        0    7  *  *  1-5   /home/pi/cmstv/mon.sh on
        0   20  *  *  *     /home/pi/cmstv/mon.sh off
        */5  *  *  *  *     /home/pi/cmstv/start_cmstv.sh > /dev/null

Now it should be ready after reboot (no further interaction needed):

        sudo reboot
