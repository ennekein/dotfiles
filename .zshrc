# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/loracett/scm/dotfiles/oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="ys"
#ZSH_THEME="refined"
ZSH_THEME="amuse"
#ZSH_THEME="robbyrussell"

#RPROMPT=%F{246}%K{246}%F{234}%D{%H:%M:%S}%f%k
#PROMPT=%{%K{246}%F{234}%}%n%{%F{246}%K{239}%}%{%F{246}%}%m%{%F{239}%K{237}%}%{%F{246}%}%~%{%(?:%F{46}%} ✔%{:%F{196}%} ✘%{)%k%F{237}%}%{%f%}
#
#RPROMPT=%F{252}%K{252}%F{235}%D{%H:%M:%S}%f%k
#PROMPT=%{%K{252}%F{235}%}%n%{%F{252}%K{236}%}%{%F{247}%}%m%{%F{236}%K{234}%}%{%F{247}%}%~%{%(?:%F{46}%} ✔%{:%F{196}%} ✘%{)%k%F{234}%}%{%f%}

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git virtualenvwrapper)

source $ZSH/oh-my-zsh.sh

# User configuration
export LC_ALL="en_US.UTF-8"

zstyle ':completion:*' menu select
zstyle :compinstall filename '/home/loracett/.zshrc'

autoload -Uz compinit
compinit
#
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

#
#setopt share_history

# if command isn't found, suggests a likely package to install
[[ -e /etc/zsh_command_not_found ]] && source /etc/zsh_command_not_found
export COMMAND_NOT_FOUND_INSTALL_PROMPT=1

ZLE_RPROMPT_INDENT=0


# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias du1='sudo du -h -d 1 . 2>/dev/null | sort -r -h -k1'
alias screen='echo $SSH_CLIENT | cut -d" " -f1 >~/.screen_last_ssh_client && screen'
alias tmux='echo $SSH_CLIENT | cut -d" " -f1 >~/.tmux_last_ssh_client && tmux'
alias p='ps aux|awk '"'"'$11!~/^\[/{print $0}'"'"
alias vimf='vim $(fzf)'

# if you do a 'rm *', Zsh will give you a sanity check!
setopt RM_STAR_WAIT

# # Zsh has a spelling corrector
setopt CORRECT

export EDITOR=/usr/bin/env vim
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR

TERM=xterm-256color

eval `dircolors ~/.dircolors.256dark`


# from https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
#    ESC[ … 38;5;<n> … m Select foreground color
#    ESC[ … 48;5;<n> … m Select background color
#    0x00-0x07:  standard colors (as in ESC [ 30–37 m)
#    0x08-0x0F:  high intensity colors (as in ESC [ 90–97 m)
#    0x10-0xE7:  6 × 6 × 6 cube (216 colors): 16 + 36 × r + 6 × g + b (0 ≤ r, g, b ≤ 5)
#    0xE8-0xFF:  grayscale from black to white in 24 steps
function term-256-color-test()
{
    for fgbg in 38 48 ; do #Foreground/Background
        echo "Standard colors"
        for ((color=0; color<8; color++)); do
            echo -en "\e[${fgbg};5;${color}m $(echo '   '${color}|tail -c 4)\e[0m"
        done
        echo #New line
        echo #New line
        echo "High-intensity colors"
        for ((color=8; color<16; color++)); do
            echo -en "\e[${fgbg};5;${color}m $(echo '   '${color}|tail -c 4)\e[0m"
        done
        echo #New line
        echo #New line
        for ((color=16; color<232; color++)); do
            #Display the color
            echo -en "\e[${fgbg};5;${color}m $(echo '   '${color}|tail -c 4)\e[0m"
            #Display 36 colors per lines
            if [ $((($color - 15) % 36)) = 0 ] ; then
                echo #New line
            fi
        done
        echo #New line
        echo "Grayscale colors"
        for ((color=232; color<256; color++)); do
            echo -en "\e[${fgbg};5;${color}m $(echo '   '${color}|tail -c 4)\e[0m"
        done
        echo #New line
        echo #New line
    done
}

function term-truecolor-test()
{
    printf "\x1b[38;2;255;100;0mTRUECOLOR\x1b[0m\n"
    awk 'BEGIN{
        s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
        for (colnum = 0; colnum<77; colnum++) {
            r = 255-(colnum*255/76);
            g = (colnum*510/76);
            b = (colnum*255/76);
            if (g>255) g = 510-g;
            printf "\033[48;2;%d;%d;%dm", r,g,b;
            printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
            printf "%s\033[0m", substr(s,colnum+1,1);
        }
        printf "\n";
    }'
}


function countdown(){
    date1=$((`date +%s` + $1)); 
    while [ "$date1" -ge `date +%s` ]; do 
        echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
        sleep 0.1
    done
}
function stopwatch(){
    date1=`date +%s`; 
    while true; do 
        echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r"; 
        sleep 0.1
    done
}

# install spell to get /usr/share/dict/words
function randomWord() {
    shuf -n${1:-3} /usr/share/dict/words | sed "s/'//" | sed "s/.*/\u&/" | paste -s -d '' -
}

function randomWordSpace() {
    shuf -n${1:-3} /usr/share/dict/words | sed "s/'//" | sed "s/.*/\u&/" | paste -s -d ' ' -
}

# if [ -e ~/.vim/plugged/gruvbox/gruvbox_256palette.sh ]; then 
#     ~/.vim/plugged/gruvbox/gruvbox_256palette.sh
# fi


if [ -e ~/.pythonrc ]; then 
    export PYTHONSTARTUP=~/.pythonrc
    export VIRTUALENVWRAPPER_PYTHON='/usr/bin/python3'
    export WORKON_HOME=$HOME/.virtualenvs
    export PYTHONDONTWRITEBYTECODE=1 # don't write .pyc files to disk
    source /usr/local/bin/virtualenvwrapper.sh
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi


if [ -f ~/.fzf.zsh ] ; then
    source ~/.fzf.zsh
    export FZF_COMPLETION_TRIGGER=''
    bindkey '^T' fzf-completion
    bindkey '^I' $fzf_default_completion
fi


# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
# Emacs style
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

