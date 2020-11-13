# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

alias shit='sudo $(fc -ln -1)' #for when you forget to sudo
alias sudo='sudo ' #used so that sudo evaluates aliases
alias agin='apt-get install '
alias agrm='apt-get remove '

pushd()
{
  if [ $# -eq 0 ]; then
    DIR="${HOME}"
  else
    DIR="$1"
  fi

  builtin pushd "${DIR}" > /dev/null
}

pushd_builtin()
{
  builtin pushd > /dev/null
}

popd()
{
  builtin popd > /dev/null
}

alias cd='pushd'
alias back='popd'
alias flip='pushd_builtin'

alias cp='cp -i'
alias mv='mv -i'

# enable color support of ls and grep
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

#literally just for cd/ls typos
#function cd() { builtin cd "$@" && ls; }
function cl() { pushd "$@" && ls; }
function ccd() { pushd "$@" && ls; }
function d() { pushd "$@" && ls; }
#function cla() { builtin cd "$@" && ls -la; }
function sl() { ls; }
function lsc() { ls; }

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#vi mode for terminal
#set -o vi
set -o emacs

#avoid ctrl-s causing terminal xoff signal
stty -ixon

shopt -s histverify
shopt -s histreedit
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar


# If not running interactively, don't do anything
#case $- in
#    *i*) ;;
#      *) return;;
#esac

#use vim by default to edit in most programs
export VISUAL=vim
export EDITOR="$VISUAL"

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

PROMPT_COMMAND="history -a;$PROMPT_COMMAND" # save history after every command; interleaves history between multiple terminals

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
#HISTSIZE=1000
#HISTFILESIZE=2000
#instead, set history size to be infinite
export HISTFILESIZE=
export HISTSIZE=

# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history


# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes


if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt


# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

#git branch in prompt, overrides all previous PS1
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="${PS1%?} \$(parse_git_branch)\[\033[00m\]$ "

# use vim to read man pages
export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""

# prompts to install package when command not found
export COMMAND_NOT_FOUND_INSTALL_PROMPT=1


# deal with dark blue on black color scheme for bash on ubuntu on windows
#LS_COLORS='rs=0:di=1;35:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';
#export LS_COLORS

#cuda commands
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64"
export CUDA_HOME=/usr/local/cuda

#turn off the annoying error sound for bash on ubuntu on windows
#echo set bell-style none >> .inputrc

#howto: change terminal color scheme
#wget -O gogh https://git.io/vQgMr && chmod +x gogh && ./gogh && rm gogh

###########################################################
#work, specifically crossover machine

#machine specific

#docker
if [ -n "$CONTAINER" ]; then
  PS1_PREFIX="\[\033[01;35m\][docker] \[\033[00m\]"
else
  PS1_PREFIX=""
fi
unset color_prompt force_color_prompt
PS1="${PS1_PREFIX}${PS1}"

#normally set by drive script but avoided because it fucks up the container for CI
#export DISPLAY=:0

alias scrapebag='python ~/scripts/scrape_ros_bags.py'

alias s3mount='s3fs plusai ~/s3 -o uid=${UID},gid=${UID},umask=227,passwd_file=${HOME}/.passwd-s3fs-us -d'
#https://github.com/s3fs-fuse/s3fs-fuse/issues/333
#https://github.com/s3fs-fuse/s3fs-fuse/issues/305
#alias s3szmount='s3fs public-plusai ~/s3 -o url=http://18.222.250.114:8888,uid=${UID},gid=${UID},umask=227,passwd_file=${HOME}/.passwd-s3fs-suzhou,sigv2,use_path_request_style -f -d'

alias rostime='rosparam set use_sim_time true'
alias tmks='tmux kill-session -t runtime'

export PATH=/usr/local/cuda/bin:$PATH
export ROS_MASTER_URI=http://localhost:11311
export GLOG_v=3

#drive repo
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/nvidia-410
#export DRIVE_ROOT=/home/shawnghu/drive
export DISTCC_HOSTS=localhost/32

#logs
alias cddlog='cd ~/drive/opt/debug/log/plusai'
alias cdrlog='cd ~/drive/opt/relwithdebinfo/log/plusai'

#autoformatting
alias format='clang-format -style=file -i'

alias cleardisplayenv='unset DISPLAY; unset XAUTHORITY; unset XSOCK;'
