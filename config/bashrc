#██████   █████  ███████ ██   ██ ██████   ██████
#██   ██ ██   ██ ██      ██   ██ ██   ██ ██
#██████  ███████ ███████ ███████ ██████  ██
#██   ██ ██   ██      ██ ██   ██ ██   ██ ██
#██████  ██   ██ ███████ ██   ██ ██   ██  ██████

#allows to cd into directory by typing the name
shopt -s autocd
# Enable history appending instead of overwriting.  #139609
shopt -s histappend

HISTSIZE= HISTFILESIZE= # Infinite history
# use arrow up/down to  search bash history
#bind '"\e[A": history-search-backward'
#bind '"\e[B": history-search-forward'
bind '"\e[1;2A": history-search-backward'
bind '"\e[1;2B": history-search-forward'

[[ $- != *i* ]] && return

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

use_color=true

alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'

alias cp="cp -i" # confirm before overwriting something
alias df='df -h' # human-readable sizes
#alias free='free -m'                    # show sizes in MB
#alias rm='rm -i' # Enryu confirm before removing something
#alias np='nano -w PKGBUILD'

xhost +local:root >/dev/null 2>&1

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

############################################################
# Enryu:
############################################################

bind 'set completion-ignore-case on'

### Aliases: ###

# Root privileges:
#alias doas='doas --'
alias doas='sudo'

alias nv='nvim'
alias hx='helix'

# Misc:
alias ls='ls --color=auto -h --group-directories-first'
alias ll='ls -l'
alias la='ls -la'
alias ..='cd ..'
alias c='clear'

## Temp?? for my app
alias pl='/home/enryu/Main/git/pixelLauncher/python/main.py'
alias ok='/home/enryu/Main/git/clipboardShare/python/main.py'

# virtualization shtuff
#export LIBVIRT_DEFAULT_URI='qemu:///system'

