for script in $ZDOT_DIR/profile/profile.d/*.zsh
do
    [ -r "$script" ] && . "$script"
done
unset script
