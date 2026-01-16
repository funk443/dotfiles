#!/bin/sh

eval $(ssh-agent -s)
export XDG_CURRENT_DESKTOP=sway:wlroots

exec sway
