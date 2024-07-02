#!/bin/bash

# A small script to fix suspend problem on my thinkpad.  Basically
# after I suspend the laptop, it automatically wakes up as soon as I
# close the lid, which is fucking annoying.  Code stole from
# <https://bbs.archlinux.org/viewtopic.php?id=292633>.

PATH=/sbin:/bin:/usr/bin
LID_PATH=/proc/acpi/button/lid/LID/state

if [[ "${1}" == "post" ]]; then
    grep -q closed $LID_PATH
    if [ $? = 0 ]; then
        echo freeze > /sys/power/state
    fi
fi
