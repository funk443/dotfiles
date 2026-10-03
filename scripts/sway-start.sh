#!/bin/sh

eval $(ssh-agent -s)

XDG_CURRENT_DESKTOP=sway:wlroots

export XDG_CURRENT_DESKTOP

exec dbus-run-session -- sway
