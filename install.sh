#!/bin/bash

## Install AFP

sudo apt-get install -y netatalk

### Replace afp.conf

sudo rm -f /etc/netatalk/afp.conf
sudo mv afp.conf-dist /etc/netatalk/afp.conf

### Create a dedicated AFP directory

mkdir ../videos

## Install Node.js & NPM

curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs

## Install dependencies

sudo apt-get install -y omxplayer

## Make Node.js service

sudo npm install forever -g
sudo npm install forever-service -g
sudo forever-service install osc-node

## Install OSC-Node

npm install

## write out current crontab

sudo crontab -l > mycron

## echo new cron into cron file

sudo echo "@reboot sudo mount /dev/sda1 /mnt/usb && sudo service osc-node start" >> mycron
sudo echo "@reboot sleep 20 && sudo $PWD/update.sh >> /dev/console" >> mycron

## install new cron file

sudo crontab mycron
sudo rm mycron

## Finish

sudo reboot
