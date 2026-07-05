#!/bin/sh

eval $(ssh-agent -s)

GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
SDL_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx

export GTK_IM_MODULE QT_IM_MODULE SDL_IM_MODULE XMODIFIERS

exec dbus-run-session i3
