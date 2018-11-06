#!/bin/bash

GrubRescue() {
cat << _EOF_
This along with all other functions in this work are products of my
imagination, a bit of RUM, a lot of research following countless other
gents and masters in the ways of linux and brainstorming. Use this work at 
your own risk. First we'll need to get a bit of information from ya.
This information will help us to hack into your actual hard drive from a 
live environment. Let's get started love!
_EOF_

	#This lists the available drives and gets the chosen root partition from user
	sudo fdisk -l 
	sleep 2
	echo "Please enter the device that has the root partition on it."
	read device
	sudo mount $device /mnt
	sudo mount --bind dev /mnt/dev
	sudo mount --bind proc /mnt/proc
	sudo mount --bind sys /mnt/sys
	sudo chroot /mnt
	echo "Now we need to get the drive you wish to reinstall grub on.
	This usually is the same device you mounted without the partition 
	number on the end of it."
	echo "Please enter the drive you wish to install grub on"
	read drive
	sudo grub-install $drive
	sudo grub-install --recheck $drive
	sudo update-grub
	
	#This unmounts all the things and then reboots
	echo "Now we will unmount the bindings and reboot, sit tight, this 
	may take a while."
	sleep 1
	exit
	sudo umount --bind sys /mnt/sys
	sudo umount --bind proc /mnt/proc
	sudo umount --bind dev /mnt/dev
	sudo umount /mnt
	sudo systemctl reboot

	clear
	Greeting
}
	
SYSTEM_RESTORE(){
		Mountpoint=$(lsblk | awk '{print $7}' | grep /run/media/$USER/*)
	if [[ $Mountpoint != /run/media/$USER/* ]];
	then
		read -p "Please insert the backup drive and hit enter..."
		echo $(lsblk | awk '{print $1}')
		sleep 1
		echo "Please select the device from the list"
		read device
		sudo mount $device /mnt 
		sudo rsync -aAXv --delete /mnt/$host-backups/* /
		sudo sync 
		Restart
	elif [[ $Mountpoint == /run/media/$USER/* ]];
	then
		read -p "Found a block device at designated coordinates... If this is the preferred
		drive, try unmounting the device, leaving it plugged in, and running this again. Press enter to continue..."
	fi 

	clear
	Greeting
}

Greeting(){
	echo "1 - SYSTEM RESTORE"
	echo "2 - Grub Rescue"

	read selection;

	case $selection in
		1)
		SYSTEM_RESTORE
	;;
		2)
		GrubRescue
	;;
esac
}

Greeting