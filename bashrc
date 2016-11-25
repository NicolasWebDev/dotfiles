#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [[ `uname -n` == "ArchFloe" ]]
then
    echo "I'm on the ThinkPad"
    export PATH="$HOME/.rbenv/bin:$HOME/todo.txt-cli:$HOME/work/my_scripts:$PATH"
    eval "$(rbenv init -)"
    # hook for finding package providing unknown command
    source /usr/share/doc/pkgfile/command-not-found.bash
    #------------------------- PROMPT ---------------------------------
    PS1="${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
    #------------------------- ALIASES --------------------------------
    ## Pacman aliases ##
    alias pac='sudo /usr/bin/pacman -S'
    alias ya='/usr/bin/yaourt -S'
    alias pacu='sudo /usr/bin/pacman -Syu'
    alias yau='/usr/bin/yaourt -Syua'
    alias pacr='sudo /usr/bin/pacman -Rs'
    alias pacs='/usr/bin/pacman -Ss'
    alias yas='/usr/bin/yaourt -Ss'
    alias pacuu='sudo /usr/bin/pacman -U *.pkg.*'
    alias paci='/usr/bin/pacman -Si'
    alias paclo='/usr/bin/pacman -Qdt'   # list all orphaned packages
    alias pacc='sudo /usr/bin/pacman -Scc'
    alias paclf='/usr/bin/pacman -Ql'
    alias pacq='/usr/bin/pacman -Q | grep'
    # recursively remove ALL orphaned packages
    alias pacro="/usr/bin/pacman -Qtdq > /dev/null && sudo /usr/bin/pacman -Rns \$(/usr/bin/pacman -Qtdq | sed -e ':a;N;$!ba;s/\n/ /g')"
    # function to print packages by size
    pacman-size()
    {
        pacman -Qi | awk '/^Name/ {pkg=$3} /Size/ {print $4$5,pkg}' | sort -n
    }

    ## Yaourt aliases ##
    alias yas='yaourt -Ss'
    alias yag='yaourt -G'
    # list obsolete packages from the AUR
    alias yao='for file in `pacman -Qmq` ; do yas $file | grep "installed:" ; done'
elif [[ `uname -n` == "nicolas-envydv7" ]]
then
    echo "Je suis sur l'ordi de ProtelCotelsa"
    export CODECOV_TOKEN=f38ce4dc-b1c0-4f96-abf1-5efcc0f264d2
    alias reset_test_db='sudo -u postgres -H bash -c "export PGPASSWORD=postgres ; dropdb --if-exists -p 5433 testing ; createdb -p 5433 -T demo testing"'
    alias suspend='sflock -f "-*-fixed-*-r-*-*-*-420-*-*-*-*-*-*" ; dbus-send --system --print-reply --dest="org.freedesktop.UPower" /org/freedesktop/UPower org.freedesktop.UPower.Suspend'
    alias hibernate='sflock -f "-*-fixed-*-r-*-*-*-420-*-*-*-*-*-*" ; dbus-send --system --print-reply --dest="org.freedesktop.UPower" /org/freedesktop/UPower org.freedesktop.UPower.Hibernate'
    alias bzrc='bzr diffstat | tail -n1 | cut -d',' -f2- | sed "s/^[^[:digit:]]*\([[:digit:]]*\)[^[:digit:]]*\([[:digit:]]*\).*$/\1 - \2/g" | bc'
    alias odoo_tests_install='./openerp-server -c .openerp_serverrc --stop-after-init -d testing -i'
    alias odoo_merge='bzr merge && bzr ci -m "[MRG]" && cd .. && ./run_tests.py -m oly_customize && cd - && bzr push'
    alias screens_mirror="xrandr --output LVDS1 --mode 1440x900 --output VGA1 --mode 1440x900 --same-as LVDS1"
    alias screens_split="xrandr --output LVDS1 --mode 1600x900 --output VGA1 --mode 1440x900 --right-of LVDS1"
    alias screens_detach="xrandr --output VGA1 --off --output LVDS1 --mode 1600x900"
    alias backup_work_pc='sudo rsync -aSAXv --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found","/home/nicolas/.gvfs","/home/nicolas/.cache"} --delete / /media/backup_work/backup_work'
    function find_tests_time()
    {
        cat $1 | grep 'Ran' | cut -d' ' -f2- | sed 's/Ran //' | sed 's/tests in //' | sed 's/s$//' | sed 's/test in //' | sed 's/^\(.*:\) \([[:digit:]]\+\) \([[:digit:]]\+\)\.\([[:digit:]]\+\)/echo "\1 \2 tests at" $(echo "scale=1; \2 \/ \3.\4" | bc) "tests\/second"/' | bash | sort -nr -k5
    }
    function disable_tp()
    {
        xinput set-prop $(xinput | grep TouchPad | cut -d'=' -f2 | cut -f1) "Device Enabled" 0
    }
    function enable_tp()
    {
        xinput set-prop $(xinput | grep TouchPad | cut -d'=' -f2 | cut -f1) "Device Enabled" 1
    }
    #------------------------- PROMPT ---------------------------------
    PS1="${debian_chroot:+($debian_chroot)}\[\033[01;35m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
    #---------------------------- PATH ------------------------------
    PATH="$HOME/.rbenv/bin:$PATH:$HOME/.cabal/bin:/usr/local/bin:/opt/sonar-runner-2.4/bin:~/.bin:$HOME/IT/perso/exercism/bin"
    #------------------------- ALIASES --------------------------------
    alias apt='sudo /usr/sbin/apt-fast install'
    alias aptu='sudo /usr/sbin/apt-fast update ; sudo /usr/sbin/apt-fast -V upgrade'
    alias aptr='sudo /usr/sbin/apt-fast purge'
    alias apti='/usr/bin/apt-cache show'
    alias bzrl='/usr/bin/bzr log --show-ids'
    alias bzri='/usr/bin/bzr log --show-ids -r-1 | grep revision-id | cut -d'-' -f3'
    alias greppy='/bin/grep --color=auto --include="*.py" -rn'
    alias grepxml='/bin/grep --color=auto --include="*.xml" -rn'
    eval "$(rbenv init -)"

    ### Added by the Heroku Toolbelt
    export PATH="/usr/local/heroku/bin:$PATH"
else
    echo "Je suis sur un ordi inconnu"
fi

#------------------------ OTHER ------------------------------------
# That line is used to enable auto-completion after sudo command.
complete -cf sudo

export MOZ_DISABLE_PANGO=1
export PAGER="less -r"
export EDITOR=vim
export BROWSER=firefox
export HISTSIZE=5000
export DO=104.236.197.222
source "$HOME/.secrets.sh"

# This disables freezing the terminal with a <CTRL>s.
stty stop undef

# X Terminal titles
case "$TERM" in
    xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'
    ;;
*)
    ;;
esac
#---------------------------- PATH ------------------------------

#------------------------- ALIASES --------------------------------
alias odoo_tests_install='./openerp-server -c .openerp_serverrc --stop-after-init -d testing -i'
alias odoo_reset_test_db='sudo -u postgres -H bash -c "export PGPASSWORD=postgres ; dropdb --if-exists -p 5434 testing ; createdb -p 5434 -T demo testing"'
alias odoo_server='./odoo.py -c .openerp_serverrc'
alias firefox='firefox-aurora'
alias t='todo.sh'
alias vimwaiting="vim $HOME/todo.txt-cli/waiting.txt"
alias vimtodo="vim $HOME/todo.txt-cli/todo.txt"
alias vimbashrc="vim $HOME/.bashrc ; source $HOME/.bashrc"
alias vimsomeday="vim $HOME/todo.txt-cli/someday_maybe.txt"
alias vimreminders="vim $HOME/.reminders"
alias ping="ping www.archlinux.org"
alias be='setxkbmap fr bepo ; echo "keyboard switched to bepo"'
alias pu='setxkbmap es ; echo "keyboard switched to spanish"'
#alias less=$PAGER
alias ll='ls --color=auto -lX'
alias vimgtd="cd $HOME/todo.txt-cli ; vim waiting.txt -o someday_maybe.txt -c ':vs projects.txt' -c ':wincmd j' -c ':vs todo.txt'"
alias ls='ls --color=auto'
alias b='bundle exec'
alias greprb='/bin/grep --color=auto --include="*.rb" -rn'
alias lc='ls --color=auto --format=single-column'
alias hist='history | grep'
alias mkdir='mkdir -pv'
alias poweroff='systemctl poweroff'
alias youtube-dl-sub='youtube-dl --write-sub --sub-lang en --sub-format vtt'
alias remc='remind -cum -w162,0 ~/.reminders'
alias remd='remind -z -k"notify-send -u critical -t 60000 %s &" ~/.reminders'
alias remc2='remind -cu2 -m -w162,0 ~/.reminders'
alias reboot='systemctl reboot'
alias screen_hdmi='xrandr | grep -q "HDMI-1 connected" && xrandr --output eDP-1 --off --output HDMI-1 --auto || echo "HDMI-1 is not connected"'
alias screen_detach='xrandr --output eDP-1 --auto --output HDMI-1 --off'
alias screen_mirror="xrandr --output eDP-1 --mode 1920x1080 --output HDMI-1 --mode 1920x1080 --same-as eDP-1"
alias screen_split="xrandr --output eDP-1 --mode 1920x1080 --output HDMI-1 --mode 1920x1080 --right-of eDP-1"
alias rsync-backup='rsync -av --progress --delete --stats'
alias svim='sudo /usr/bin/vim'
alias mount='mount | column -t'
alias dmesg="dmesg -T|sed -e 's|\(^.*'`date +%Y`']\)\(.*\)|\x1b[0;34m\1\x1b[0m - \2|g'"
alias grep="grep --color=auto"
alias sort_someday="awk '{print \$NF,\$0}' ~/todo.txt-cli/someday_maybe.txt | sort -nr | cut -f2- -d' ' > ~/todo.txt-cli/someday_maybe.txt.back ; mv -f ~/todo.txt-cli/someday_maybe.txt{.back,}"
alias egrep="egrep --color=auto"
alias notify-send="notify-send -t 100000"
alias suspend="sflock -c ' ' -h ; systemctl suspend"
alias term_colors='for x in 0 1 4 5 7 8; do for i in `seq 30 37`; do for a in `seq 40 47`; do echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "; done; echo; done; done; echo "";'
function bzrd()
{
    bzr diff "$1" | less -r
}
function test_rc_lua()
{
    Xephyr -ac -br -noreset -screen 800x600 :1 &
    sleep 1
    DISPLAY=:1.0 awesome -c ~/.config/awesome/rc.lua.new
}
function markdown2html()
{
    MD_FILE=$1
    HTML_FILE=$2
    pandoc -s --css=file://$HOME/.markdown.css $MD_FILE > $HTML_FILE
}
function preview-markdown()
{
    MD_FILE=$1
    HTML_FILE="/tmp/$(basename $MD_FILE .md).html"
    markdown2html $MD_FILE $HTML_FILE
    firefox $HTML_FILE
}
function odoo-kill()
{
    kill -s SIGKILL $(ps aux | grep openerp | grep python | awk '{print $2}')
}
# to remove beeping in the terminal
set bell-style none

## Safety features ##
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'
alias ln='ln -i'

# --- KEYCHAIN ---
# Used to keep rsa keys opened once for each boot.
eval $(keychain --eval --quiet id_rsa)

# prepend TERM=linux ensures that there is no problem connecting via ssh on a
# machine which doesn't use urxvt as I do

# Cette commande permet d'ouvrir firefox à partir d'un autre PC via SSH,
# en utilisant un autre profile qui est synchronisé avec celui par défaut.
# Mais est-ce vraiment utile d'utiliser un autre profile ?
# Manifestement oui car selon mozilla-fanzine le répertoire utilisateur  est vérouillé pendant l'utilisation,
# et un simple -no-remote ne permet pas d'ouvrir une seconde instance via SSH, l'utilisation de deux profils
# différents assure que les accès concurrents sont bien gérés via Firefox Sync (ce qui ne serait surement 
# pas le cas en contournant le problème en faisant un lien symbolique du second profil sur le principal) (par 
# contre il doit falloir
# synchroniser les extensions manuellement).
#alias firefox_ssh='firefox -no-remote -P second'

#------------------------ LESS COLORS FOR MAN PAGES ----------------
#export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
#export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
#export LESS_TERMCAP_me=$'\E[0m'           # end mode
#export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
#export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
#export LESS_TERMCAP_ue=$'\E[0m'           # end underline
#export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

# different scheme
export LESS_TERMCAP_mb=$(printf '\e[01;31m') # enter blinking mode
export LESS_TERMCAP_md=$(printf '\e[01;38;5;75m') # enter double-bright mode
export LESS_TERMCAP_me=$(printf '\e[0m') # turn off all appearance modes (mb, md, so, us)
export LESS_TERMCAP_se=$(printf '\e[0m') # leave standout mode
export LESS_TERMCAP_so=$(printf '\e[01;33m') # enter standout mode
export LESS_TERMCAP_ue=$(printf '\e[0m') # leave underline mode
export LESS_TERMCAP_us=$(printf '\e[04;38;5;200m') # enter underline mode

# yet another scheme
#export LESS_TERMCAP_mb=$(printf '\e[01;31m') # enter blinking mode - red
#export LESS_TERMCAP_md=$(printf '\e[01;35m') # enter double-bright mode - bold, magenta
#export LESS_TERMCAP_me=$(printf '\e[0m') # turn off all appearance modes (mb, md, so, us)
#export LESS_TERMCAP_se=$(printf '\e[0m') # leave standout mode
#export LESS_TERMCAP_so=$(printf '\e[01;33m') # enter standout mode - yellow
#export LESS_TERMCAP_ue=$(printf '\e[0m') # leave underline mode
#export LESS_TERMCAP_us=$(printf '\e[04;36m') # enter underline mode - cyan
