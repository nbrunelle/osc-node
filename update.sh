#!/bin/bash
DIR="/mnt/usb/"

if [ -d "$DIR" ]; then
        if [ "$(ls -A $DIR)" ]; then
                echo "Checking if file already exist..."
                # If folder exist, do action
                # check if file exist or is the same
                cd /mnt/usb/
                files=(*)
                FILE=/home/pi/video.mp4
                if [ -f "$FILE" ]; then
                        echo "$FILE exists."
                else
                        echo "$FILE does not exist."
                        touch /home/pi/video.mp4
                fi

                fileOnUsb=$(wc -c $files | awk '{print $1}'s)
                fileOnDisk=$(wc -c /home/pi/video.mp4 | awk '{print $1}'s)
                if [ $fileOnUsb != $fileOnDisk ]; then
                        echo "Coping files... (wait)"
                        pv -f $files > /home/pi/video.mp4
                        echo "Copy finished, rebooting..."
                        reboot
                else
                        echo "File of identic size is already present on disk."
                fi
                cd /home/pi/
                echo "Unmounting USB"
                umount /mnt/usb/
        else
                # Mount disk
                echo "Mouting disk"
                mount /dev/sda1 /mnt/usb/
                ./$0
        fi
else
        mkdir /mnt/usb/
        # Mount disk
        echo "Mouting disk"
        mount /dev/sda1 /mnt/usb/
        ./$0
fi