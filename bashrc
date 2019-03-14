#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH="$HOME/.rbenv/bin:$HOME/todo.txt-cli:$HOME/work/my_scripts:$HOME/.cabal/bin:$HOME/.local/bin:$PATH"
export RUBYLIB="$HOME/work/my_scripts:$RUBYLIB"
eval "$(rbenv init -)"
source /usr/share/nvm/init-nvm.sh
# hook for finding package providing unknown command
source /usr/share/doc/pkgfile/command-not-found.bash
#------------------------- PROMPT ---------------------------------
PS1="${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
#------------------------- ALIASES --------------------------------
## Pacman aliases ##
alias pac='sudo /usr/bin/pacman -S'
alias ya='/usr/bin/yay -S'
alias pacu='sudo /usr/bin/pacman -Syu'
alias yau='/usr/bin/yay'
# Download only.
alias yaw='/usr/bin/yay -Syuw'
alias pacr='sudo /usr/bin/pacman -Rs'
alias pacs='/usr/bin/pacman -Ss'
alias yas='/usr/bin/yay'
# Archlinux news.
alias yan='/usr/bin/yay -Pww'
alias pacuu='sudo /usr/bin/pacman -U *.pkg.*'
alias paci='/usr/bin/pacman -Si'
alias yai='/usr/bin/yay -Si'
alias yag='/usr/bin/yay -G'
alias paclo='/usr/bin/pacman -Qdt'   # list all orphaned packages
alias pacc='sudo /usr/bin/pacman -Scc'
alias paclf='/usr/bin/pacman -Ql'
alias pacq='/usr/bin/pacman -Q | grep'
# recursively remove ALL orphaned packages
alias pacro="/usr/bin/pacman -Qtdq > /dev/null && sudo /usr/bin/pacman -Rns \$(/usr/bin/pacman -Qtdq | sed -e ':a;N;$!ba;s/\n/ /g')"
alias pacman_size='pacgraph -c' # print installed packages by size

# list obsolete packages from the AUR
alias yao='for file in `pacman -Qmq` ; do yas $file | grep "installed:" ; done'

#------------------------ OTHER ------------------------------------
# That line is used to enable auto-completion after sudo command.
complete -cf sudo

export MOZ_DISABLE_PANGO=1
export WINEARCH=win32
export WINEPREFIX=$HOME/.wine
export PAGER="less -r"
export EDITOR=nvim
export BROWSER=/usr/bin/chromium
export HISTSIZE=5000
export DO=104.236.197.222
export CALIBRE_USE_SYSTEM_THEME="true"
source "$HOME/.secrets.sh"
# Taken from http://owen.cymru/fzf-ripgrep-navigate-with-bash-faster-than-ever-before
set -o vi
source "/usr/share/fzf/key-bindings.bash"
source "/usr/share/fzf/completion.bash"
export FZF_DEFAULT_COMMAND='rg --files 2>/dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
bind -x '"\C-p": nvim $(fzf);'
# Completion file for tmuxinator.
source "$HOME/.tmuxinator.bash"

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
alias transtes='trans :es'
alias transfes='trans es:'
alias x='exit'
alias o='mimeo'
alias odoo_tests_install='./openerp-server -c .openerp_serverrc --stop-after-init -d testing -i'
alias odoo_reset_test_db='sudo -u postgres -H bash -c "export PGPASSWORD=postgres ; dropdb --if-exists -p 5434 testing ; createdb -p 5434 -T demo testing"'
alias odoo_server='./odoo.py -c .openerp_serverrc'
alias firefox='firefox-aurora'
alias t='todo.sh'
alias public_ip='dig +short myip.opendns.com @resolver1.opendns.com'
alias d='sudo docker'
alias scope_a="backlog_scope \"$HOME/todo.txt-cli/todo.txt $HOME/todo.txt-cli/*.backlog.todo.txt\" '\(A\) ' | sum_digits"
alias scope_b="backlog_scope \"$HOME/todo.txt-cli/todo.txt $HOME/todo.txt-cli/*.backlog.todo.txt\" '\(B\) ' | sum_digits"
alias top="htop"
alias cat="bat"
alias scope_ready="backlog_scope \"$HOME/todo.txt-cli/*.backlog.todo.txt\" '\+ready'"
alias dc='sudo docker-compose'
alias tree1='tree -L 1'
alias v='nvim'
alias n='nvim'
alias tree2='tree -L 2'
alias psgrep='ps aux | grep -v grep | grep'
alias vimwaiting="$EDITOR $HOME/todo.txt-cli/waiting.txt"
alias scanimage="scanimage --device 'pixma:04A9176C_A5C6D3'"
alias subdl="subdl --download=best-rating"
alias vimtodo="$EDITOR $HOME/todo.txt-cli/todo.txt"
alias ssh='TERM=xterm-256color ssh'
alias vimbashrc="$EDITOR $HOME/.bashrc ; source $HOME/.bashrc"
alias vimvimrc="$EDITOR $HOME/.config/nvim/init.vim"
alias vimsomeday="$EDITOR $HOME/todo.txt-cli/someday_maybe.txt"
alias ping="ping www.archlinux.org"
alias be='setxkbmap fr bepo ; echo "keyboard switched to bepo"'
alias pu='setxkbmap es ; echo "keyboard switched to spanish"'
#alias less=$PAGER
# To avoid spotify muting chrome, per the issue
# https://github.com/serialoverflow/blockify/issues/92
alias spotify='PULSE_PROP="module-stream-restore.id=spotify" /usr/bin/spotify'
alias ll='ls --color=auto -lX'
alias vimgtd="cd $HOME/todo.txt-cli ; $EDITOR waiting.todo.txt -o someday.todo.txt -c ':vs projects.todo.txt' -c ':wincmd j' -c ':vs todo.txt' -c ':tabedit general.backlog.todo.txt' -c ':tabedit ziembra.backlog.todo.txt' -c ':tabedit marketing.backlog.todo.txt' -c ':tabedit growth.backlog.todo.txt'"
alias gtdprojects="rg ' |^\+\S+ ' -o todo.txt-cli/someday.todo.txt | tr -d ' ' | sort | uniq -c | sort -n | tac"
alias ls='ls --color=auto'
alias b='bundle exec'
alias gc='git commit -v'
alias gca='git commit -av'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias ga='git add'
alias gap='git add -p'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gco='git checkout'
alias gbr='git branch'
alias glf="git lf"
function github {
    git clone --depth 1 https://github.com/$1
}
alias lc='ls --color=auto --format=single-column'
alias hist='history | grep'
alias mkdir='mkdir -pv'
alias poweroff='systemctl poweroff'
alias youtube-dl-sub='youtube-dl --write-sub --sub-lang en --sub-format vtt'
_CAL_OPTIONS='--monday --military --width=29'
alias cal='gcalcli'
alias cals='gcalcli search'
alias calw="gcalcli calw $_CAL_OPTIONS"
alias calm="gcalcli calm $_CAL_OPTIONS"
function cala() {
    gcalcli agenda --military --width=29 --details attendees --details length --details email "$@" | rg -v "Email: info@nicolaswebdev.com|Length: 1 day|Length: 1:00:00"
}
function calan() {
    _caladd info@nicolaswebdev.com "$@"
}
function calaz() {
    _caladd Ziembra "$@"
}
function calai() {
    _caladd IQBit "$@"
}
function _caladd() {
    CALENDAR=$1
    WHEN=$2
    TITLE=$3
    DURATION=${4:-60}
    OTHERS=("${@:5}")
    gcalcli --calendar "$CALENDAR" add --title "$TITLE" --when "$WHEN" --reminder 30 --duration "$DURATION" ${OTHERS[*]}
}
function flac2ogg() {
    DIR=$1
    find "$DIR" -name "*flac" -exec oggenc -q 7 {} \;
}
function flac2mp3() {
    parallel ffmpeg -i {} -qscale:a 0 {.}.mp3 ::: ./*.flac
}
function ogg2mp3() {
    parallel ffmpeg -i "{}" "{.}.mp3" ::: *.{ogg,opus}
}
function m4a2mp3() {
    parallel ffmpeg -i "{}" "{.}.mp3" ::: *.m4a
}
function stories_done() {
    tac $HOME/todo.txt-cli/done.txt | sed '/\+scrum SP/q'
}
function stories_b() {
    rg -c '\(B\) ' $HOME/todo.txt-cli/todo.txt $HOME/todo.txt-cli/*.backlog.todo.txt | sum_digits
}
function stories_sprint() {
    REMAINING=$(rg -c '\((A|B)\) ' $HOME/todo.txt-cli/todo.txt)
    DONE=$(stories_done | wc -l)
    printf "%-20s%d\n" todo.txt $REMAINING
    printf "%-20s%d\n" done.txt $DONE
    printf "%-20s%d\n" total $(bc <<< "$REMAINING+$DONE")
}
function scope_done() {
    stories_done | sed 's/^.*\*\([0-9.]*\).*$/\1/' | paste -sd+ | bc
}
function scope_sprint() {
    REMAINING=$(backlog_scope $HOME/todo.txt-cli/todo.txt '\((A|B)\) ' | grep -o '[[:digit:]][.[:digit:]]*')
    DONE=$(scope_done)
    printf "%-20s%.1f\n" todo.txt $REMAINING
    printf "%-20s%.1f\n" done.txt $DONE
    printf "%-20s%.1f\n" total $(bc <<< "$REMAINING+$DONE")
}
# Echoes standard input, and print the sum of the numbers it contains.
function sum_digits() {
    tee /dev/tty | rg -o '\d+(\.\d+)?' | paste -sd+ | bc
}
function backlog_scope() {
    FILES=$1
    REGEX=$2
    for FILE in $FILES
    do
        printf "%-20s" $(basename $FILE .backlog.todo.txt)
        ESTIMATES=$(rg $REGEX $FILE | sed 's/^.*\*\([0-9.]*\).*$/\1/')
        if [[ $ESTIMATES ]]
        then
            printf "%3.1f\n" $(echo "$ESTIMATES" | paste -sd+ | bc)
        else
            echo 0
        fi
    done
}
function project_time()
{
    pomodori2time $(grep -c "$1" $HOME/work/documentation/journal.md)
}
function pomodori2time()
{
    printf "%02d:%02.f\n" $(echo "$1 * 32.5 / 60" | bc) $(echo "$1 * 32.5 % 60" | bc)
}
function todo_time ()
{
    grep -v "^x" todo.txt-cli/todo.txt | grep "$1.*\*[0-9]\+" | sed 's/.*\*\([0-9]\+\)/\1/' | awk '{s+=$1} END {printf("%02d:%02d", int(s/60),s % 60)}'
}
function validate_todo_format()
{
    ! (grep -v "^@" todo.txt-cli/todo.txt | grep -v "^x " | grep -v "^([A-D]).* #[a-z] +[a-z_]\+ .* \*[0-9]\+")
}
function todo_times ()
{
    validate_todo_format || return 1
    echo "A:        $(todo_time '(A)')"
    echo "B:        $(todo_time '(B)')"
    echo "C:        $(todo_time '(C)')"
    echo "D:        $(todo_time '(D)')"
    echo "Total:    $(todo_time)"
}
function mutt ()
{
    cd $HOME/Downloads
    /usr/bin/mutt "$@"
    cd -
}
alias reboot='systemctl reboot'
alias screen_hdmi='xrandr | grep -q "HDMI-1 connected" && xrandr --output eDP-1 --off --output HDMI-1 --auto || echo "HDMI-1 is not connected"'
alias screen_projector='xrandr --output eDP-1 --mode 1920x1080 --output DP-2 --mode 1280x800 --right-of eDP-1'
alias screen_detach_projector='xrandr --output eDP-1 --auto --output DP-2 --off'
alias screen_detach='xrandr --output eDP-1 --auto --output HDMI-1 --off'
alias screen_mirror="xrandr --output eDP-1 --mode 1920x1080 --output HDMI-1 --mode 1920x1080 --same-as eDP-1"
alias screen_split="xrandr --output eDP-1 --mode 1920x1080 --output HDMI-1 --mode 1920x1080 --right-of eDP-1"
alias rsync-backup='rsync -av --progress --delete --stats'
alias svim='sudo /usr/bin/nvim'
alias dfh='df -h'
alias mount='mount | column -t'
alias dmesg="dmesg -T|sed -e 's|\(^.*'`date +%Y`']\)\(.*\)|\x1b[0;34m\1\x1b[0m - \2|g'"
alias grep="grep --color=auto"
alias sort_someday="awk '{print \$NF,\$0}' ~/todo.txt-cli/someday_maybe.txt | sort -nr | cut -f2- -d' ' > ~/todo.txt-cli/someday_maybe.txt.back ; mv -f ~/todo.txt-cli/someday_maybe.txt{.back,}"
alias egrep="egrep --color=auto"
alias notify-send="notify-send -t 10000"
export TERM_ICON="/usr/share/icons/Mint-X/apps/96/bash.svg"
alias notify-completion="/usr/bin/notify-send -t 10000 -i $TERM_ICON Task completed ; beep"
alias suspend="sflock -c ' ' -h ; systemctl suspend"
alias term_colors='for x in 0 1 4 5 7 8; do for i in `seq 30 37`; do for a in `seq 40 47`; do echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "; done; echo; done; done; echo "";'
export GAD_IP=181.112.151.237
function guard_python() {
    watchmedo shell-command -R --patterns="*.py" --command='[ ${watch_event_type} = modified ] && green -r'
}
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
    pandoc -s --css=file://$HOME/work/markdown.css $MD_FILE > $HTML_FILE
}
function markdown2pdf()
{
    MD_FILE=$1
    PDF_FILE=$2
    pandoc -V geometry:margin=1in -s --css=file://$HOME/work/markdown.css $MD_FILE -o $PDF_FILE
}
function preview-markdown()
{
    MD_FILE=$1
    HTML_FILE="/tmp/$(basename $MD_FILE .md).html"
    markdown2html $MD_FILE $HTML_FILE
    $BROWSER $HTML_FILE
}
function lpr_preview ()
{
    lpr -P pdf_printer "$@"
    sleep 1
    evince $(ls -t /var/spool/cups-pdf/sathors/*.pdf | head -n1) &
}
function odoo-kill()
{
    kill -s SIGKILL $(ps aux | grep openerp | grep python | awk '{print $2}')
}

function du_sorted()
{
    du -hs "$@" | sort -h
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

# --- DIRCOLORS ---
# Set the colors used by ls and tree.
eval $(dircolors -b $HOME/.dircolors)

if [ -f /usr/lib/bash-git-prompt/gitprompt.sh ]; then
	# To only show the git prompt in or under a repository directory
	#GIT_PROMPT_ONLY_IN_REPO=1
	GIT_PROMPT_THEME=Custom
	source /usr/lib/bash-git-prompt/gitprompt.sh
fi

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
export LESS_TERMCAP_so=$(printf '\e[01;33;41m') # enter standout mode
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
