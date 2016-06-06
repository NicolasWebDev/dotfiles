# source .bashrc file if present
[[ -f ~/.bashrc ]] && . ~/.bashrc
# See http://serverfault.com/questions/92683/execute-rsync-command-over-ssh-with-an-ssh-agent-via-crontab.
if [ -x /usr/bin/keychain ]; then
    /usr/bin/keychain --quiet $HOME/.ssh/id_rsa
fi
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
