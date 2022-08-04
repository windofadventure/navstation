export XDG_CURRENT_DESKTOP=Budgie:GNOME
#exec budgie-desktop --debug --whale
#exec sleep 5 && openbox --replace
exec gnome-session --builtin --session=budgie-desktop $*
exec budgie-desktop


