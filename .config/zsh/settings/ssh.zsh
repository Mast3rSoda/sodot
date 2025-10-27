sodot_ssh_home="$HOME/.ssh"

# check if systemd enabled
ssh_sock_loc="$XDG_RUNTIME_DIR/ssh-agent.socket"
if [ -S $ssh_sock_loc ]; then
    export SSH_AUTH_SOCK=$ssh_sock_loc
    return
fi

# ssh_sock_loc="$sodot_ssh_home/ssh_sock_loc"


# load the agent
# BUG: somehow once the file was created
# and I couldn't overwrite it. Happened after
# a forced restart. Eval was ran, but connection error.
# # Removing the link helped
# if [ ! -S $ssh_sock_loc ]; then
#   eval `ssh-agent -s`
#   ln -sf "$SSH_AUTH_SOCK" $ssh_sock_loc
# fi
# export SSH_AUTH_SOCK=$ssh_sock_loc
#
# # manually add secret keys
# if ! ssh-add -l>/dev/null; then
#     for key in $sodot_ssh_home/*.pub
#     do
#         ssh-add ${key%.pub} >/dev/null
#     done
# fi
