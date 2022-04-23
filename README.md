# OSC-Node
Modified from marsvaardig's [osc-node](https://github.com/marsvaardig/osc-node).

The modification aim to automate and ease the process of setting up a synchronized video projection.  


[Raspberry Pi](https://www.raspberrypi.org/) video player controlled by over [OSC](http://opensoundcontrol.org/) written in [Node.js](https://nodejs.org/en/) using [Omxplayer](https://elinux.org/Omxplayer).
It can be controlled with software like [Chataigne](https://github.com/benkuper/Chataigne) or [sendosc](https://github.com/yoggy/sendosc).

## Added functionalities

- Automatic file copy
- Command to navigate back 30 seconds


## Install Raspbian

Install the latest [Raspbian Stretch Lite](https://www.raspberrypi.org/downloads/raspbian/) on your SD card using the [Raspberry Pi Imager](https://www.raspberrypi.org/downloads/).

### Setup SSH Access

Create an empty file in the root of the SD card named `ssh` (without dot or extension).

    $ touch /Volumes/boot/ssh

## Install OSC-Node

SSH into your Pi and excecute:

    $ sudo apt-get install -y git
    $ git clone https://github.com/nbrunelle/osc-node.git osc-node && cd $_
    $ sh install.sh

## Update file 

Plug a USB with only one `.mp4` on it.
It will be automatically copied to `/home/pi/video.mp4` and reboot.

## Copy videos onto Pi using AFP

Connect from your Mac with a simple command:

`open afp://pi:raspberry@192.168.xxx.xxx`

Or use Finder > Connect to Server

## Setup OSC software

### Network

Network Cue Destionation Patches:

- Destination: IP address of the Raspberry Pi
- Port: 99998

### OSC message

Available OSC addresses & argements:

- `/play /home/pi/videos/big_buck_bunny.mp4`
- `/loop /home/pi/videos/big_buck_bunny.mp4`
- `/stop`
- `/prev`
- `/pause` (pause & resume)
- `/cmd "sudo reboot"`


