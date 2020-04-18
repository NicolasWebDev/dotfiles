[[ $- != *i* ]] && return # If not running interactively, don't do anything.

# Temporary fix for mdn docsets in Zeal.
# See https://github.com/zealdocs/zeal/issues/1155#issuecomment-553213420
zeal-docs-fix() {
    pushd "$HOME/.local/share/Zeal/Zeal/docsets" >/dev/null || return
    find . -iname 'react-main*.js' -exec rm '{}' \;
    popd >/dev/null || exit
}
# zeal-docs-fix

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
    export FZF_DEFAULT_COMMAND='fd --type f'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_DEFAULT_OPTS='--bind ctrl-t:down,ctrl-s:up --reverse --no-height'
    export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always {} | head -500' --select-1"
    export FZF_ALT_R_OPTS="--select-1 --preview 'echo {}' --preview-window down:3:wrap --bind '?:toggle-preview'"
    export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
    source "/usr/share/fzf/key-bindings.bash"
    # Disabling because takes too much time and I don't use it.
    # source "/usr/share/fzf/completion.bash"
    bind -x '"\C-o": output="$(fzf)" && history -s "mimeo $output" && mimeo "$output"' # C-o is used to open a file using mimeo.
    bind -x '"\C-p": output="$(fzf)" && history -s "nvim $output" && nvim "$output";' # C-p is used to open a file using nvim.
    bind '"\er": shell-expand-line' # Necessary for the next bind.
    bind '"\C-f": "$(fd --type d | fzf | perl -pe chomp | xargs -I @ printf %q "@")\er"' # Search a Folder and places it at the cursor position.
# }}}

# RUBY CONFIGURATION {{{
    export RUBYLIB="$HOME/work/my_scripts:$RUBYLIB"
# }}}

# VARIABLES {{{
    PS1="${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
    export PATH="$HOME/todo.txt-cli:$HOME/work/my_scripts:$PATH"
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
    # NVM {{{
        # To fix slow bash startup time:
        # https://github.com/nvm-sh/nvm/issues/1277#issuecomment-536218082
        [ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
        source /usr/share/nvm/nvm.sh --no-use
        source /usr/share/nvm/bash_completion
        source /usr/share/nvm/install-nvm-exec
        export PATH="$NVM_DIR/versions/node/v$(<$NVM_DIR/alias/default)/bin:$PATH"
        alias nvm="unalias nvm; [ -s '/usr/local/opt/nvm/nvm.sh' ] && . '/usr/local/opt/nvm/nvm.sh'; nvm $@"
    # }}}
    # Use bash-completion, if available
    [[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
            . /usr/share/bash-completion/bash_completion

    source /usr/share/doc/pkgfile/command-not-found.bash # Hook to suggest package for an unknown command.
    complete -cf sudo # That line is used to enable auto-completion after sudo command.
    source "$HOME/.tmuxinator.bash" # Completion file for tmuxinator.
    eval $(keychain --eval --noask --quiet id_rsa second_id_rsa) # Used to keep rsa keys opened once for each boot.
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
        alias gds='git diff --compact-summary'
        alias gdcs='git diff --cached --compact-summary'
        alias glf="git lf"
        alias gs='git status'
        alias git2="GIT_SSH_COMMAND='ssh -i /home/sathors/.ssh/second_id_rsa' git"
    # }}}

    # EXA {{{
        export LS_COLORS="*.mp3=38;5;135" # To make mp3 more readable in exa.
    # }}}

    # PACMAN {{{
        alias ya='/usr/bin/yay -S'
        alias ya_dropped_packages="comm -23 <(pacman -Qqm | sort) <(curl https://aur.archlinux.org/packages.gz | gzip -cd | sort)" # Find packages I have installed which are not in aur anymore. (ref: https://wiki.archlinux.org/index.php/Arch_User_Repository#How_do_I_find_out_if_any_of_my_installed_packages_disappeared_from_AUR?)
        alias ya_size='pacgraph -c' # print installed packages by size
        alias yac='/usr/bin/yay -Scc'
        alias yag='/usr/bin/yay -G'
        alias yai='/usr/bin/yay -Si'
        alias yalf='/usr/bin/yay -Ql'
        alias yaqi='/usr/bin/yay -Qi'
        alias yalo='/usr/bin/yay -Qdt'   # list all orphaned packages
        alias yan='/usr/bin/yay -Pww' # Archlinux news.
        alias yao='for file in `pacman -Qmq` ; do yas $file | grep "installed:" ; done' # List obsolete packages from the AUR.
        alias yaq='/usr/bin/yay -Q | grep'
        alias yar='/usr/bin/yay -Rs'
        alias yaro="/usr/bin/pacman -Qtdq > /dev/null && sudo /usr/bin/pacman -Rns \$(/usr/bin/pacman -Qtdq | sed -e ':a;N;$!ba;s/\n/ /g')" # Recursively remove ALL orphaned packages.
        alias yas='/usr/bin/yay'
        alias yau='/usr/bin/yay'
        alias yauu='/usr/bin/yay -U'
        alias yaw='/usr/bin/yay -Syuw --repo --answerupgrade None --noconfirm' # Download only.
    # }}}

    # SCREEN {{{
        alias screen_detach='xrandr --output eDP1 --auto --output HDMI1 --off'
        alias screen_detach_projector='xrandr --output eDP1 --auto --output DP-2 --off'
        alias screen_hdmi='xrandr | grep -q "HDMI1 connected" && xrandr --output eDP1 --off --output HDMI1 --auto || echo "HDMI1 is not connected"'
        alias screen_mirror="xrandr --output eDP1 --mode 1920x1080 --output HDMI1 --mode 1920x1080 --same-as eDP1"
        alias screen_projector='xrandr --output eDP1 --mode 1920x1080 --output DP-2 --mode 1280x800 --right-of eDP1'
        alias screen_split="xrandr --output eDP1 --mode 1920x1080 --output HDMI1 --mode 1920x1080 --right-of eDP1"
    # }}}

    # PYTHON {{{
        alias activate='source venv/bin/activate'
    # }}}

    alias cloc='scc'
    alias cp_address='echo "Ed. Almagro Plaza, Suite 1012, Pedro Ponce Carrasco E8-06 y Diego de Almagro Quito, Ecuador" | xb'
    alias d='sudo docker'
    alias docker_clean_images='sudo docker rmi $(sudo docker images -q)'
    alias docker_clean_containers='sudo docker rm $(sudo docker ps -qa)'
    alias docker_clean_volumes='sudo docker volume rm $(sudo docker volume ls -q)'
    alias dc='sudo docker-compose'
    alias dfh='df -h'
    alias hist='history | grep'
    alias ll='exa --classify --long'
    alias backup_mount='sudo mount /dev/sda6 /mnt/data ; sudo mount /dev/sdb5 /mnt/backup'
    alias backup_umount='sudo umount /mnt/backup'
    alias mount_galaxy='jmtpfs ~/mnt/galaxy'
    alias notify-completion="/usr/bin/notify-send -t 10000 -i $TERM_ICON Task completed ; beep"
    alias notify-send="notify-send -t 10000"
    alias o='mimeo'
    alias passl="pass | less -r"
    alias playmidi='aplaymidi -p 128:0'
    alias poweroff='systemctl poweroff'
    alias psgrep='ps aux | grep -v grep | grep'
    alias public_ip='dig +short myip.opendns.com @resolver1.opendns.com'
    alias random_album="rg '^\d{2,3}\.' docs/lists/music.md | shuf -n 1"
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
    alias switch_flip4='switch_bluetooth_device Flip F8:DF:15:E9:D3:BA'
    alias switch_thonet_and_vander='switch_bluetooth_device Frei 23:E6:B1:30:46:CC'
    alias t='todo.sh'
    alias te='trans en:en'
    alias term_colors='for x in 0 1 4 5 7 8; do for i in `seq 30 37`; do for a in `seq 40 47`; do echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "; done; echo; done; done; echo "";'
    alias tfs='trans es:'
    alias tree1='exa --tree --level=1'
    alias tree2='exa --tree --level=2'
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
    alias tree='exa --tree'
    alias beep='aplay /usr/share/sounds/alsa/finished.wav'
    alias cat="bat"
    alias cp='cp -i'
    alias egrep="egrep --color=auto"
    alias firefox='firefox-aurora'
    alias grep="grep --color=auto"
    alias dmesg="dmesg -T|sed -e 's|\(^.*'`date +%Y`']\)\(.*\)|\x1b[0;34m\1\x1b[0m - \2|g'"
    alias ln='ln -i'
    alias ssh='TERM=xterm-256color ssh'
    alias subdl="subdl --download=best-rating"
    alias ls='exa --classify'
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
    function switch_bluetooth_device() {
        DEVICE_ALIAS="$1"
        DEVICE_ID="$2"

        bluetoothctl info | grep -q "$DEVICE_ALIAS" \
            && bluetoothctl disconnect "$DEVICE_ID" \
            || bluetoothctl connect "$DEVICE_ID"
    }
    function cdiff() {
        FIRST_FILE="$1"
        SECOND_FILE="$2"
        diff -u "$FIRST_FILE" "$SECOND_FILE" | diff-so-fancy
    }
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
