#!/bin/bash
#if [ "$(id -u)" != "0" ]; then
#   echo "This script must be run like: sudo ./install.sh" 1>&2
#   exit 1
#fi

echo "Starting Install..."

sudo apt-get clean
sudo apt-get update
sudo apt-get -y install vsftpd xboxdrv stella python-pip python-requests python-levenshtein libsdl1.2-dev bc gunicorn sqlite3
git clone https://github.com/ssilverm/pimame-8 pimame
cd pimame

git submodule init
git submodule update
sudo pip install flask pyyaml flask-sqlalchemy flask-admin
cp -r config/.advance/ ~/
sudo cp config/vsftpd.conf /etc/
sudo cp config/inittab /etc/

wget http://sheasilverman.com/rpi/raspbian/8/sdl2_2.0.1-1_armhf.deb
sudo dpkg --force-overwrite -i sdl2_2.0.1-1_armhf.deb
rm sdl2_2.0.1-1_armhf.deb

cd /home/pimame/emulators
git submodule init
git submodule update


###xboxdriver
sudo apt-get -y install xboxdrv

####c64
wget http://sheasilverman.com/rpi/raspbian/installer/vice_2.3.21-1_armhf.deb
sudo dpkg -i vice_2.3.21-1_armhf.deb
rm -rf vice_2.3.21-1_armhf.deb




echo 'if [ "$DISPLAY" == "" ] && [ "$SSH_CLIENT" == "" ] && [ "$SSH_TTY" == "" ]; then' >> /home/pi/.profile

if grep --quiet /home/pi/pimame/pimame-web-frontend /home/pi/.profile; then
  echo "website already exists, ignoring."
else
	echo 'cd /home/pi/pimame/pimame-web-frontend/; sudo gunicorn app:app -b 0.0.0.0:80 &' >> /home/pi/.profile
fi
cd /home/pi/pimame/pimame-web-frontend/; sudo gunicorn --timeout 500 --log-level=debug  app:app -b 0.0.0.0:80 &

if grep --quiet /home/pi/pimame/file_watcher/ /home/pi/.profile; then
  echo "menu already exists, ignoring."
else
	echo 'cd /home/pi/pimame/file_watcher/watch.py --delay 60 --path /home/pi/pimame/roms/ &' >> /home/pi/.profile
fi

if grep --quiet /home/pi/pimame/pimame-menu /home/pi/.profile; then
  echo "menu already exists, ignoring."
else
	echo 'cd /home/pi/pimame/pimame-menu/' >> /home/pi/.profile
	echo 'python launchmenu.py' >> /home/pi/.profile
fi



echo 'fi' >> /home/pi/.profile


echo "Please restart to activate PiMAME :)"