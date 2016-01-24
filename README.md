# PiPLAY Installer and Updater

```sh
git clone https://github.com/ssilverm/piplay-installer

cd piplay-installer
```

## INSTALLING ON A NEW SD CARD

Start by provisioning an SD-Card with the latest version of Raspbian. Once Raspbian is installed, insert it into the RPi and boot it up.

From the RPi console, run the following: 

```sh
sudo apt-get install git python-pygame
mkdir ~/src
cd ~/src
git clone https://github.com/ssilverm/piplay-installer
cd pipplay-installer
bash installer.sh
```

## UPDATING TO A NEWER VERSION OF PIPLAY

```sh
bash updater.sh
```
