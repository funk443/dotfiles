#!/bin/sh

eval $(ssh-agent)
export XDG_CURRENT_DESKTOP=sway:wlroots

exec sway
