if [ -z $XDG_CURRENT_DESKTOP ]; then
  XDG_CURRENT_DESKTOP=Budgie:GNOME
  export XDG_CURRENT_DESKTOP
fi

exec budgie-desktop --session=gnome-session

