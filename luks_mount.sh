#!/bin/bash

#######################################
#                                     #
#  https://github.com/pedroguima      #
#                                     #
#######################################

DEV=/dev/yourdev
MOUNT_POINT=/opt/yourmountpoint
LUKS_DEV=/dev/mapper/yourluksdev
LUKS_NAME=yourluksname

CRYPTSETUP=$(which cryptsetup || exit 1 )

if ! $CRYPTSETUP status $LUKS_NAME > /dev/null; then
	$CRYPTSETUP luksOpen $DEV $LUKS_NAME || (echo "Error: Could not open Luks dev $DEV." && exit 2)
	mount $LUKS_DEV $MOUNT_POINT  || (echo "Error: Could not mount." && exit 3)
 	echo "Encrypted $DEV mounted!"
else
	exit 0
fi
