#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [[ `uname -n` == "ArchInspiron" ]]
then
    echo "Je suis sur le Dell Inspiron"
    # hook for finding package providing unknown command
    source /usr/share/doc/pkgfile/command-not-found.bash
    eval `dircolors -b /usr/share/LS_COLORS`
    # function to print packages by size
    pacman-size()
    {
        pacman -Qi | awk '/^Name/ {pkg=$3} /Size/ {print $4$5,pkg}' | sort -n
    }
    #------------------------- PROMPT ---------------------------------
    PS1="${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
    #---------------------------- PATH ------------------------------
    # add my scripts in the PATH
    PATH=$PATH:~/Documents/Informatique/Linux/scripts_persos
    #------------------------- ALIASES --------------------------------
    ## Pacman aliases ##
    alias pac='sudo /usr/bin/pacman -S'
    alias pacu='sudo /usr/bin/pacman -Syu'
    alias pacr='sudo /usr/bin/pacman -Rsn'
    alias pacs='/usr/bin/pacman -Ss'
    alias pacuu='sudo /usr/bin/pacman -U *.pkg.*'
    alias paci='/usr/bin/pacman -Si'
    alias paclo='/usr/bin/pacman -Qdt'   # list all orphaned packages
    alias pacc='sudo /usr/bin/pacman -Scc'
    alias paclf='/usr/bin/pacman -Ql'
    alias pacq='/usr/bin/pacman -Q'
    # recursively remove ALL orphaned packages
    alias pacro="/usr/bin/pacman -Qtdq > /dev/null && sudo /usr/bin/pacman -Rns \$(/usr/bin/pacman -Qtdq | sed -e ':a;N;$!ba;s/\n/ /g')"

    ## Yaourt aliases ##
    alias yas='yaourt -Ss'
    alias yag='yaourt -G'
    # list obsolete packages from the AUR
    alias yao='for file in `pacman -Qmq` ; do yas $file | grep "installed:" ; done'

    alias usejava5='JAVA_HOME=/opt/java5; . /opt/java5/jre/bin/usejava.sh'
    alias usejava='JAVA_HOME=/opt/java; . /opt/java5/jre/bin/usejava.sh'
    alias mntNexus7='simple-mtpfs /media/Nexus7'
    alias umntNexus7='fusermount -u /media/Nexus7'



elif [[ `uname -n` == "nicolas-envydv7" ]]
then
    echo "Je suis sur l'ordi de ProtelCotelsa"
    export SONNAR_RUNNER_HOME="/opt/sonar-runner-2.4"
    export PYTHON_PATH='/opt/openoffice4/program/'
    export bzr_repo='bzr+ssh://protel@192.168.2.226/home/protel/olympo_src8/'
    export bzr_repo_extras='bzr+ssh://protel@192.168.2.226/home/protel/olympo_extras8/'
    export openerp6ip='192.168.2.77'
    export RTW='/home/nicolas/openerp/olympo_src/oly_academic_rating/wizard/'
    export ac='oly_academic'
    export acra='oly_academic_rating'
    export aca='oly_academic_assistance'
    export acb='oly_academic_behavior'
    export acm='oly_academic_medic'
    export acro='oly_academic_route'
    export acs='oly_academic_sale'
    export ism_server='200.125.135.9'
    export LFS='/mnt/lfs'
    function preview-markdown()
    {
        MD_FILE=$1
        HTML_FILE="$(basename $MD_FILE .md).html"
        pandoc -s --css=file:///home/nicolas/.markdown.css $MD_FILE > /tmp/${HTML_FILE} ; firefox /tmp/${HTML_FILE}
    }
    function kill-openerp()
    {
        kill -s SIGKILL $(ps aux | grep openerp | grep python | awk '{print $2}')
    }
    function kill-eclipse()
    {
        kill -s SIGKILL $(ps aux | grep eclipse | awk '{print $2}')
    }
    function kill-listening_oo()
    {
        kill -s SIGKILL $(ps aux | grep soffice | head -n -1 | awk '{print $2}')
    }
    function apts()
    {
        apt-cache search $1 | sort | grep $1
    }
    function disable_tp()
    {
        xinput set-prop $(xinput | grep TouchPad | cut -d'=' -f2 | cut -f1) "Device Enabled" 0
    }
    function enable_tp()
    {
        xinput set-prop $(xinput | grep TouchPad | cut -d'=' -f2 | cut -f1) "Device Enabled" 1
    }
    function aptq()
    {
        [[ $# -eq 0 ]] && /usr/bin/dpkg -l || /usr/bin/dpkg -l | grep $1
    }
    #------------------------- PROMPT ---------------------------------
    PS1="${debian_chroot:+($debian_chroot)}\[\033[01;35m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
    #---------------------------- PATH ------------------------------
    PATH="$PATH:/opt/openoffice4/program:$HOME/.cabal/bin:/usr/local/bin:/opt/sonar-runner-2.4/bin:~/.bin"
    #------------------------- ALIASES --------------------------------
    #alias update='[[ "${PWD##*/}" = olympo_src ]] && { bzr revert oly_academic/report/__init__.py ; echo "removing patches...done" ; cd .. ; echo -n "backup creation..." ; tar zcf olympo_src_`date +%Y-%h-%d_%Hh%M`.tar.gz olympo_src ; echo "done" ; cd olympo_src ; echo "bzr update" ; bzr update ; } || echo "Error : we'"'"'re not in olympo_src"'
    #alias update='[[ "${PWD##*/}" = olympo_src ]] && { cd .. ; echo -n "backup creation..." ; tar zcf olympo_src_`date +%Y-%h-%d_%Hh%M`.tar.gz olympo_src ; echo "done" ; cd olympo_src ; echo "bzr update" ; bzr update ; } || echo "Error : we'"'"'re not in olympo_src"'
    alias sxw2rml='python /home/nicolas/openerp/openerp/addons/base_report_designer/openerp_sxw2rml/openerp_sxw2rml.py'
    alias backup_olympo='[[ "${PWD##*/}" = olympo_src ]] && { cd .. ; echo -n "backup creation..." ; tar zcf olympo_src_`date +%Y-%h-%d_%Hh%M`.tar.gz olympo_src ; echo "done" ; cd olympo_src ; } || echo "Error : we'"'"'re not in olympo_src"'
    alias listening_oo='soffice --nologo --nofirststartwizard --headless --norestore --invisible "--accept=socket,host=localhost,port=8100,tcpNoDelay=1;urp;" &'
    alias ssh_ism_server='ssh administrador@200.125.135.9'
    alias apply_patches='[[ "${PWD##*/}" = olympo_src ]] && { /bin/cp oly_academic/report/__init__.py.hack oly_academic/report/__init__.py && echo "applying patches...done" ; } || echo "Error : we'"'"'re not in olympo_src"'
    alias branch_remote='bzr branch bzr+ssh://olympoerp@68.169.60.154/home/olympoerp/olympo_src/'
    alias apt='sudo /usr/sbin/apt-fast install'
    alias aptu='sudo /usr/sbin/apt-fast update ; sudo /usr/sbin/apt-fast -V upgrade'
    alias aptr='sudo /usr/sbin/apt-fast purge'
    alias apti='/usr/bin/apt-cache show'
    alias bzrl='/usr/bin/bzr log --show-ids'
    alias bzri='/usr/bin/bzr log --show-ids -r-1 | grep revision-id | cut -d'-' -f3'
    alias adt='~/android/eclipse/eclipse'
    alias greppy='/bin/grep --color=auto --include="*.py" -rn'
    alias grepxml='/bin/grep --color=auto --include="*.xml" -rn'
    alias compile_junit='javac -cp .:/usr/share/java/junit4.jar'
    alias hist='history | grep'
    function unpatch()
    {
        for file in $(bzr st | tail -n +2 ) ; do mv -v "$file" "${file}.back" ; done
    }
    function patch()
    {
        for file in $(bzr st | tail -n +2 | tr -d ' ') ; do dir="$(dirname $file)" ; filename="$(basename $file .back)" ; mv -v ${dir}/${filename}{.back,} ; done
    }
else
    echo "Je suis sur un ordi inconnu"
fi

#------------------------ OTHER ------------------------------------
# That line is used to enable auto-completion after sudo command.
complete -cf sudo

export MOZ_DISABLE_PANGO=1
#export PAGER=vimpager
#export MANPAGER="/usr/bin/vimmanpager"
export EDITOR=vim
export BROWSER=firefox
export HISTSIZE=5000

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
alias be='setxkbmap fr bepo ; echo "keyboard switched to bepo"'
alias pu='setxkbmap es ; echo "keyboard switched to spanish"'
#alias less=$PAGER
alias ll='ls --color=auto -l'
alias ls='ls --color=auto'
alias lc='ls --color=auto --format=single-column'
alias mkdir='mkdir -pv'
alias poweroff='systemctl poweroff'
alias reboot='systemctl reboot'
alias rsync-backup='rsync -av --progress --delete --stats'
alias svim='sudo /usr/bin/vim'
alias mount='mount | column -t'
alias dmesg="dmesg -T|sed -e 's|\(^.*'`date +%Y`']\)\(.*\)|\x1b[0;34m\1\x1b[0m - \2|g'"
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias notify-send="notify-send -t 100000"

# to remove beeping in the terminal
set bell-style none

## Safety features ##
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'
alias ln='ln -i'

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

#-------------------------------------------------------------------
