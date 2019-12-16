[[ $- != *i* ]] && return # If not running interactively, don't do anything.

# XDG INITIALIZATION {{{
    # https://wiki.archlinux.org/index.php/XDG_Base_Directory
    export XDG_CONFIG_HOME="$HOME/.config"
    export XDG_CACHE_HOME="$HOME/.cache"
    export XDG_DATA_HOME="$HOME/.local/share"
# }}}

# RIPGREP CONFIGURATION {{{
    export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgreprc"
# }}}

# FZF CONFIGURATION {{{
    set -o vi # Taken from http://owen.cymru/fzf-ripgrep-navigate-with-bash-faster-than-ever-before. Has to be set before sourcing the key-bindings else they will not work.
    export FZF_DEFAULT_COMMAND='rg --files 2>/dev/null'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    source "/usr/share/fzf/key-bindings.bash"
    source "/usr/share/fzf/completion.bash"
    bind -x '"\C-p": mimeo "$(fzf)";' # C-p is used to open a file using nvim.
# }}}

# GCALCLI CONFIGURATION {{{
    _CAL_OPTIONS='--monday --military --width=29'
    alias cal='gcalcli'
    alias calm="gcalcli calm $_CAL_OPTIONS"
    alias cals='gcalcli search'
    alias calw="gcalcli calw $_CAL_OPTIONS"
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
    function cala() {
        gcalcli agenda --military --width=29 --details attendees --details length --details email "$@" | rg -v "Email: info@nicolaswebdev.com|Length: 1 day|Length: 1:00:00"
    }
    function calan() {
        _caladd info@nicolaswebdev.com "$@"
    }
# }}}

# RUBY CONFIGURATION {{{
    export RUBYLIB="$HOME/work/my_scripts:$RUBYLIB"
    alias b='bundle exec'
# }}}

# VARIABLES {{{
    PS1="${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
    export PATH="$HOME/.rbenv/bin:$HOME/todo.txt-cli:$HOME/work/my_scripts:$HOME/.cabal/bin:$HOME/.local/bin:$PATH"
    export TERM_ICON="/usr/share/icons/Mint-X/apps/96/bash.svg"
    export MOZ_DISABLE_PANGO=1
    export WINEARCH=win32
    export WINEPREFIX=$HOME/.wine
    source "$HOME/.secrets.sh"
    export PAGER="less -r"
    export EDITOR=nvim
    export BROWSER=/usr/bin/chromium
    export HISTSIZE=5000
    export DO=104.236.197.222
    export CALIBRE_USE_SYSTEM_THEME="true"
# }}}

# INITIALIZATION {{{
    eval "$(rbenv init -)" # Initialize rbenv.
    source /usr/share/nvm/init-nvm.sh # Initialize nvm.
    source /usr/share/doc/pkgfile/command-not-found.bash # Hook to suggest package for an unknown command.
    complete -cf sudo # That line is used to enable auto-completion after sudo command.
    source "$HOME/.tmuxinator.bash" # Completion file for tmuxinator.
    eval $(keychain --eval --quiet id_rsa) # Used to keep rsa keys opened once for each boot.
    eval $(dircolors -b $HOME/.dircolors) # Set the colors used by ls and tree.
# }}}

# GTD {{{
    alias vimgtd="cd $HOME/todo.txt-cli ; $EDITOR waiting.todo.txt -o someday.todo.txt -c ':vs projects.todo.txt' -c ':wincmd j' -c ':vs todo.txt' -c ':tabedit general.backlog.todo.txt' -c ':tabedit ziembra.backlog.todo.txt' -c ':tabedit marketing.backlog.todo.txt' -c ':tabedit growth.backlog.todo.txt'"
    alias scope_a="backlog_scope \"$HOME/todo.txt-cli/todo.txt $HOME/todo.txt-cli/*.backlog.todo.txt\" '\(A\) ' | sum_digits"
    alias scope_b="backlog_scope \"$HOME/todo.txt-cli/todo.txt $HOME/todo.txt-cli/*.backlog.todo.txt\" '\(B\) ' | sum_digits"
    alias scope_ready="backlog_scope \"$HOME/todo.txt-cli/*.backlog.todo.txt\" '\+ready'"
    alias vimsomeday="$EDITOR $HOME/todo.txt-cli/someday_maybe.txt"
    alias sort_someday="awk '{print \$NF,\$0}' ~/todo.txt-cli/someday_maybe.txt | sort -nr | cut -f2- -d' ' > ~/todo.txt-cli/someday_maybe.txt.back ; mv -f ~/todo.txt-cli/someday_maybe.txt{.back,}"
    alias vimtodo="$EDITOR $HOME/todo.txt-cli/todo.txt"
    alias vimvimrc="$EDITOR $XDG_CONFIG_HOME/nvim/init.vim"
    alias vimwaiting="$EDITOR $HOME/todo.txt-cli/waiting.txt"
    alias vds="$EDITOR ~/work/gtd/processes.md -c ':tabedit ~/work/gtd/experiments.md'"
    alias gtdprojects="rg -o '\+\S+' ~/todo.txt-cli/someday.todo.txt | sort | uniq -c | sort -n | tac"
    function transpose_lilypond_from_c_to_eb() {
        LILYPOND_SHEET="$1"

        cat $LILYPOND_SHEET | \
            sed "s/\ba\(is\|es\|[0-9 :',]\)/la\1/g" | \
            sed "s/\bb\(is\|es\|[0-9 :',]\)/si\1/g" | \
            sed "s/\bc\(is\|es\|[0-9 :',]\)/do\1/g" | \
            sed "s/\bd\(is\|es\|[0-9 :',]\)/re\1/g" | \
            sed "s/\be\(is\|es\|[0-9 :',]\)/mi\1/g" | \
            sed "s/\bf\(is\|es\|[0-9 :',]\)/fa\1/g" | \
            sed "s/\bg\(is\|es\|[0-9 :',]\)/sol\1/g" | \
            sed 's/\bdo/a/g' | \
            sed 's/\bdois/ais/g' | \
            sed 's/\brees/bes/g' | \
            sed 's/\bre\([^lp]\)/b\1/g' | \
            sed 's/\breis/c/g' | \
            sed 's/\bees/c/g' | \
            sed 's/\bmi\([^nd]\)/cis\1/g' | \
            sed 's/\bfa/d/g' | \
            sed 's/\bfais/dis/g' | \
            sed 's/\bsoles/ees/g' | \
            sed 's/\bsol/e/g' | \
            sed 's/\bsolis/f/g' | \
            sed 's/\blaes/f/g' | \
            sed 's/\bla\([^y]\)/fis\1/g' | \
            sed 's/\blais/g/g' | \
            sed 's/\bsies/g/g' | \
            sed 's/\bsi/gis/g'
    }
    function project_time() {
        pomodori2time $(grep -c "$1" $HOME/work/documentation/journal.md)
    }
    function pomodori2time() {
        printf "%02d:%02.f\n" $(echo "$1 * 32.5 / 60" | bc) $(echo "$1 * 32.5 % 60" | bc)
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
    function todo_time () {
        grep -v "^x" todo.txt-cli/todo.txt | grep "$1.*\*[0-9]\+" | sed 's/.*\*\([0-9]\+\)/\1/' | awk '{s+=$1} END {printf("%02d:%02d", int(s/60),s % 60)}'
    }
    function validate_todo_format() {
        ! (grep -v "^@" todo.txt-cli/todo.txt | grep -v "^x " | grep -v "^([A-D]).* #[a-z] +[a-z_]\+ .* \*[0-9]\+")
    }
    function substract_times () {
        # Usage: substract_times 15:27:33 13:46:51
        # returns: 1:40:42
        IFS=: read hour1 min1 sec1 <<< "$1"
        IFS=: read hour2 min2 sec2 <<< "$2"
        total_sec1=$((hour1*60*60 + min1*60 + sec1))
        total_sec2=$((hour2*60*60 + min2*60 + sec2))
        difference_sec=$((total_sec1 - total_sec2))
        hours=$((difference_sec / 60 / 60))
        mins=$((difference_sec / 60 % 60))
        secs=$((difference_sec % 60))
        printf "%02d:%02d:%02d\n" $hours $mins $secs
    }
    function todo_times () {
        validate_todo_format || return 1
        echo "A:        $(todo_time '(A)')"
        echo "B:        $(todo_time '(B)')"
        echo "C:        $(todo_time '(C)')"
        echo "D:        $(todo_time '(D)')"
        echo "Total:    $(todo_time)"
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
# }}}

# ALIASES {{{
    # GIT {{{
        alias ga='git add'
        alias gap='git add -p'
        alias gbr='git branch'
        alias gc='git commit -v'
        alias gca='git commit -av'
        alias gcam='git commit -a -m'
        alias gcm='git commit -m'
        alias gco='git checkout'
        alias gd='git diff'
        alias gdc='git diff --cached'
        alias glf="git lf"
        alias gs='git status'
    # }}}

    # PACMAN {{{
        alias dropped_packages="comm -23 <(pacman -Qqm | sort) <(curl https://aur.archlinux.org/packages.gz | gzip -cd | sort)" # Find packages I have installed which are not in aur anymore. (ref: https://wiki.archlinux.org/index.php/Arch_User_Repository#How_do_I_find_out_if_any_of_my_installed_packages_disappeared_from_AUR?)
        alias pac='sudo /usr/bin/pacman -S'
        alias pacc='sudo /usr/bin/pacman -Scc'
        alias paci='/usr/bin/pacman -Si'
        alias paclf='/usr/bin/pacman -Ql'
        alias paclo='/usr/bin/pacman -Qdt'   # list all orphaned packages
        alias pacman_size='pacgraph -c' # print installed packages by size
        alias pacq='/usr/bin/pacman -Q | grep'
        alias pacr='sudo /usr/bin/pacman -Rs'
        alias pacro="/usr/bin/pacman -Qtdq > /dev/null && sudo /usr/bin/pacman -Rns \$(/usr/bin/pacman -Qtdq | sed -e ':a;N;$!ba;s/\n/ /g')" # Recursively remove ALL orphaned packages.
        alias pacs='/usr/bin/pacman -Ss'
        alias pacu='sudo /usr/bin/pacman -Syu'
        alias pacuu='sudo /usr/bin/pacman -U *.pkg.*'
        alias ya='/usr/bin/yay -S'
        alias yag='/usr/bin/yay -G'
        alias yai='/usr/bin/yay -Si'
        alias yan='/usr/bin/yay -Pww' # Archlinux news.
        alias yao='for file in `pacman -Qmq` ; do yas $file | grep "installed:" ; done' # List obsolete packages from the AUR.
        alias yas='/usr/bin/yay'
        alias yau='/usr/bin/yay'
        alias yaw='/usr/bin/yay -Syuw --repo --answerupgrade None --noconfirm' # Download only.
    # }}}

    # SCREEN {{{
        alias screen_detach='xrandr --output eDP-1 --auto --output HDMI-1 --off'
        alias screen_detach_projector='xrandr --output eDP-1 --auto --output DP-2 --off'
        alias screen_hdmi='xrandr | grep -q "HDMI-1 connected" && xrandr --output eDP-1 --off --output HDMI-1 --auto || echo "HDMI-1 is not connected"'
        alias screen_mirror="xrandr --output eDP-1 --mode 1920x1080 --output HDMI-1 --mode 1920x1080 --same-as eDP-1"
        alias screen_projector='xrandr --output eDP-1 --mode 1920x1080 --output DP-2 --mode 1280x800 --right-of eDP-1'
        alias screen_split="xrandr --output eDP-1 --mode 1920x1080 --output HDMI-1 --mode 1920x1080 --right-of eDP-1"
    # }}}

    alias connect_flip4='bluetoothctl connect F8:DF:15:E9:D3:BA'
    alias d='sudo docker'
    alias dc='sudo docker-compose'
    alias dfh='df -h'
    alias hist='history | grep'
    alias lc='ls --color=auto --format=single-column'
    alias ll='ls --color=auto -lX'
    alias backup_mount='sudo mount /dev/sda6 /mnt/data ; sudo mount /dev/sdb5 /mnt/backup'
    alias backup_umount='sudo umount /mnt/backup'
    alias mount_galaxy='jmtpfs ~/mnt/galaxy'
    alias notify-completion="/usr/bin/notify-send -t 10000 -i $TERM_ICON Task completed ; beep"
    alias notify-send="notify-send -t 10000"
    alias o='mimeo'
    alias poweroff='systemctl poweroff'
    alias psgrep='ps aux | grep -v grep | grep'
    alias public_ip='dig +short myip.opendns.com @resolver1.opendns.com'
    alias reboot='systemctl reboot'
    alias rsync-backup='rsync -av --progress --delete --stats'
    alias sbe='setxkbmap fr bepo ; echo "keyboard switched to bepo"'
    alias scanimage="scanimage --device 'pixma:04A9176C_A5C6D3'"
    alias snakecase="tr '[:upper:]' '[:lower:]' | tr ' ' '_'"
    alias sus='setxkbmap us ; echo "keyboard switched to us"'
    alias s="sflock -c ' ' -h ; systemctl suspend"
    alias sv='sudoedit'
    alias svd='EDITOR="nvim -d" sudoedit'
    alias svim='sudo /usr/bin/nvim'
    alias t='todo.sh'
    alias te='trans en:en'
    alias term_colors='for x in 0 1 4 5 7 8; do for i in `seq 30 37`; do for a in `seq 40 47`; do echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "; done; echo; done; done; echo "";'
    alias tfs='trans es:'
    alias tree1='tree -L 1'
    alias tree2='tree -L 2'
    alias ts='trans es:es'
    alias tts='trans :es'
    alias umount_galaxy='fusermount -u ~/mnt/galaxy'
    alias utf82ascii='iconv -f utf-8 -t ascii//translit' # To encode quickly from utf-8 to ascii, trying to keep the right letters (é/ê/è/ë -> e).
    alias v='nvim'
    alias vd='nvim -d'
    alias vimbashrc="$EDITOR $HOME/.bashrc ; source $HOME/.bashrc"
    alias x='exit'
    alias xb="xsel -b"
    alias xp="xsel"
    alias xs="xsel -s"
    alias youtube-dl-sub='youtube-dl --write-sub --sub-lang en --sub-format vtt'
# }}}

# ENCODING {{{
    function cue2flac() {
        CUE_FILE="$1"
        AUDIO_FILE="$2"

        shnsplit -f "$CUE_FILE" -t "%n %t" -o flac "$AUDIO_FILE"
    }
    function cue2ogg() {
        CUE_FILE="$1"
        AUDIO_FILE="$2"

        shnsplit -f "$CUE_FILE" -t "%n %t" -o "cust ext=ogg oggenc -o %f -" "$AUDIO_FILE"
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
# }}}

# OVERWRITE COMMANDS {{{
    alias beep='aplay /usr/share/sounds/alsa/finished.wav'
    alias cat="bat"
    alias cp='cp -i'
    alias egrep="egrep --color=auto"
    alias firefox='firefox-aurora'
    alias grep="grep --color=auto"
    alias dmesg="dmesg -T|sed -e 's|\(^.*'`date +%Y`']\)\(.*\)|\x1b[0;34m\1\x1b[0m - \2|g'"
    alias ln='ln -i'
    alias spotify='PULSE_PROP="module-stream-restore.id=spotify" /usr/bin/spotify' # To avoid spotify muting chrome, per the issue https://github.com/serialoverflow/blockify/issues/92.
    alias ssh='TERM=xterm-256color ssh'
    alias subdl="subdl --download=best-rating"
    alias ls='ls --color=auto'
    alias mkdir='mkdir -pv'
    alias mount='mount | column -t'
    alias mv='mv -i'
    alias rm='rm -I'
    alias ping="ping www.archlinux.org"
    alias top="htop"
    function mutt () {
        cd $HOME/Downloads
        /usr/bin/mutt "$@"
        cd -
    }
# }}}

# FUNCTIONS {{{
    function sum_digits() { # Echoes standard input, and print the sum of the numbers it contains.
        tee /dev/tty | rg -o '\d+(\.\d+)?' | paste -sd+ | bc
    }
    function github {
        git clone --depth 1 https://github.com/$1
    }
    function vdate {
        NAME=$1
        $EDITOR $(date +%F)_$NAME.md
    }
    function titlecase() {
        sed 's/.*/\L&/; s/[a-z]*/\u&/g'
    }
    function test_rc_lua() {
        Xephyr -ac -br -noreset -screen 800x600 :1 &
        sleep 1
        DISPLAY=:1.0 awesome -c "$XDG_CONFIG_HOME/awesome/rc.lua.new"
    }
    function markdown2html() {
        MD_FILE=$1
        HTML_FILE=$2
        pandoc -s --css=file://$HOME/work/markdown.css $MD_FILE > $HTML_FILE
    }
    function markdown2pdf() {
        MD_FILE=$1
        PDF_FILE=$2
        pandoc -V geometry:margin=1in -s --css=file://$HOME/work/markdown.css $MD_FILE -o $PDF_FILE
    }
    function preview-markdown() {
        MD_FILE=$1
        HTML_FILE="/tmp/$(basename $MD_FILE .md).html"
        markdown2html $MD_FILE $HTML_FILE
        $BROWSER $HTML_FILE
    }
    function lpr_preview () {
        lpr -P pdf_printer "$@"
        sleep 1
        evince $(ls -t /var/spool/cups-pdf/sathors/*.pdf | head -n1) &
    }
    function du_sorted() {
        du -hs "$@" | sort -h
    }
# }}}

# OPTIONS {{{
    set bell-style none # To remove beeping in the terminal.
    stty stop undef # This disables freezing the terminal with a <CTRL>s.
# }}}

# X TERMINAL TITLES {{{
    case "$TERM" in
        xterm*|rxvt*)
        PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'
        ;;
    *)
        ;;
    esac
# }}}

# GIT PROMPT {{{
    if [ -f /usr/lib/bash-git-prompt/gitprompt.sh ]; then
        # To only show the git prompt in or under a repository directory
        #GIT_PROMPT_ONLY_IN_REPO=1
        GIT_PROMPT_THEME=Custom
        source /usr/lib/bash-git-prompt/gitprompt.sh
    fi
# }}}

# LESS COLORS FOR MAN PAGES {{{
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
# }}}
