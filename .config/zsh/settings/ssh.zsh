sodot_ssh_home="$HOME/.ssh"
ssh_auth_sock="$sodot_ssh_home/ssh_auth_sock"

# load the agent
if [ ! -S $ssh_auth_sock ]; then
  eval `ssh-agent -s`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock

# manually add secret keys
if ! ssh-add -l>/dev/null; then
    for key in $sodot_ssh_home/*.pub
    do
        ssh-add ${key%.pub} >/dev/null
    done
fi
