
if [ -z $XDG_CURRENT_DESKTOP ]; then
  XDG_CURRENT_DESKTOP=Budgie:GNOME
  export XDG_CURRENT_DESKTOP
fi

#exec budgie-desktop --debug --whale
#exec sleep 5 && openbox --replace

exec gnome-session --builtin --session=budgie-desktop $*
exec budgie-desktop

