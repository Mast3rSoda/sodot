sodot_ssh_home="$HOME/.ssh"

# check if systemd enabled
ssh_sock_loc="systemd/user/sockets.target.wants/ssh-agent.socket"
if [ ! -S $ssh_sock_loc ]; then
    ssh_sock_loc="$sodot_ssh_home/ssh_sock_loc"
else
    export SSH_AUTH_SOCK=$ssh_sock_loc
fi

# load the agent
# BUG: somehow once the file was created
# and I couldn't overwrite it. Happened after
# a forced restart. Eval was ran, but connection error.
# # Removing the link helped
if [ ! -S $ssh_sock_loc ]; then
  eval `ssh-agent -s`
  ln -sf "$SSH_AUTH_SOCK" $ssh_sock_loc
fi
export SSH_AUTH_SOCK=$ssh_sock_loc

# manually add secret keys
if ! ssh-add -l>/dev/null; then
    for key in $sodot_ssh_home/*.pub
    do
        ssh-add ${key%.pub} >/dev/null
    done
fi
