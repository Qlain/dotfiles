# Created by newuser for 5.5.1

#sudo mount /dev/sda3 /storage/sda3

autoload -Uz colors
colors

autoload -Uz compinit
compinit

export PATH=$PATH:/opt:/home/qlain/app/idea-IC-181.5281.24/bin:/home/qlain/app/pycharm-community-2018.1.4/bin:/home/qlain/app/android-studio/bin

alias cpuinfo='watch grep \"cpu MHz\" /proc/cpuinfo'
alias bc='bc -l'
alias ll='ls -aFl'
alias abcde='abcde -o wav'
alias eclipse='nohup /home/qlain/app/eclipse/java-oxygen/eclipse/eclipse >/dev/null 2>&1 &'
alias idea='nohup idea >/dev/null 2>&1 &'
alias pycharm='nohup pycharm >/dev/null 2>&1 &'
alias studio='nohup studio >/dev/null 2>&1 &'
alias tweet='java -jar /opt/lib/TweetByBash.jar $*'


alias ...='../..'
alias ....='../../..'

bindkey -v
bindkey "^[[3~" delete-char

setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt correct
setopt share_history
setopt histignorealldups
setopt no_flow_control

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select=2

PROMPT='%F{magenta}%}%B%n%b%f@%F{green}%B%U%m%u%b%f%# '
RPROMPT='%F{yellow}%~%f'
