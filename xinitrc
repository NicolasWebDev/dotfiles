#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi
# The following variable defines the session which is started if the user doesn't explicitly select a session
# Source: http://svn.berlios.de/svnroot/repos/slim/trunk/xinitrc.sample

#case $1 in
#kde)
	#exec ck-launch-session dbus-launch startkde
	#;;
#*) # awesome by default
    #~/Documents/Informatique/Linux/scripts_persos/awesome_autostart.sh
    udiskie --tray &
    #xrdb .Xresources (done in the awesomerc.lua)
    feh --bg-scale ~/Pictures/wallpapers/1440x900/wallpaper-522552.jpg &
	exec awesome > ~/.cache/awesome/stdout.log 2> ~/.cache/awesome/stderr.log
	#;;
#esac
