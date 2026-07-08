#!/bin/sh

eval $(ssh-agent -s)

GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
SDL_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx

export GTK_IM_MODULE QT_IM_MODULE SDL_IM_MODULE XMODIFIERS

xset r rate 250 80

xrandr --output HDMI-3 --primary --mode 2560x1440 --rate 120

feh --bg-fill ~/dotfiles/.config/sway/void.png

exec dbus-run-session i3
