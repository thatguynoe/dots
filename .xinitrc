#!/bin/sh

# xinitrc runs automatically when you run startx.

# There are some small but improtant commands that need to be run when we start
# the graphical environment. I keep those commands in ~/config/xprofile because
# that file is run automatically if someone uses a display manager (login
# screen) and so they are needed there. To prevent doubling up commands, I
# source them here with the line below.

. ~/.xprofile

# Your default WM is determined in your `~/.profile` on login. Here we run the
# proper command to run when the graphical environment starts.

exec dwm