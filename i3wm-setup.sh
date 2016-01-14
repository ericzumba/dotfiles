#!/bin/bash

sudo easy_install pip

# i3wm bindings for python
pip install i3ipc

# Music Player Daemon
sudo pacman -S --noconfirm mpd mpc

# Control pulseaudio devices
sudo pacman -S --noconfirm pavucontrol

# CLI tool to configure multiple diplays outputs
sudo pacman -S --noconfirm xorg-xrandr

# CLI Tool to control display brightness
sudo pacman -S --noconfirm xorg-xbacklight

# Powerful laucher and window switcher (better than dmenu)
sudo pacman -S --noconfirm rofi

# Tool to set global xconfigs (for xterm, rofi, urxvt, etc)
sudo pacman -S --noconfirm xorg-xrdb

# Automount devices (automatically started with my i3 config)
sudo pacman -S --noconfirm udiskie

# CLI file manager
sudo pacman -S --noconfirm ranger

# General Dependencies
sudo pacman -S --noconfirm ttf-fira-mono ttf-fira-sans urxvt-perls rxvt-unicode
