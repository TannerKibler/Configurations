#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/home/tanner/Configs/Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

trayer --edge top --align right --SetDockType true --expand true --width 10 --transparent true --tint 0x191970 --height 12 --setPartialStrut true
xsetroot -solid black
if [ -f $sysresources ]; then

    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#twm &
#xclock -geometry 50x50-1+1 &
#xterm -geometry 80x50+494+51 &
#xterm -geometry 80x20+494-0 &
#exec xterm -geometry 80x66+0+0 -name login &
#exec gnome-session
exec sudo dhcpcd wlp3s0 &
exec feh --bg-scale /home/tanner/Desktop/ArchWallpaper.png &
xset -b &
exec xcompmgr &
exec sudo modprobe vboxdrv &
exec xmonad

