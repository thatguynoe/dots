# Important Note

These cronjobs have components that require information about your current display to display notifications correctly.

When you add them as cronjobs, I recommend you precede the command with commands as those below:

```
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u $USER)/bus; export DISPLAY=:0; . $HOME/.zprofile;  then_command_goes_here
```

This ensures that notifications will display, xdotool commands will function and environmental variables will work as well.

Furthermore, if you set the `Xauthority` variable to something like `$XDG_RUNTIME_DIR/Xauthority` in `~/.zprofile`, you must include this in your crontab as well, else notifications will not display:

```
export XAUTHORITY=/run/user/$(id -u $USER)/Xauthority; ...
```
