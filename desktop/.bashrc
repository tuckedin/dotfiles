#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# alias ls='ls --color=auto'
# alias grep='grep --color=auto'
# PS1='[\u@\h \W]\$ '

alias maccel='xinput set-prop 11 "libinput Accel Profile Enabled" 0 1 0'
alias nightlight="xrandr --output DP-2 --gamma .8:.3:.3; xrandr --output HDMI-1 --gamma .8:.3:.3"
alias nonightlight="xrandr --output DP-2 --gamma 1:.7:.7; xrandr --output HDMI-1 --gamma 1:.7:.7"
alias shutdown="sudo openrc-shutdown -p now"
function gamma { xrandr --output DP-2 --gamma "$1"; xrandr --output HDMI-1 --gamma "$1"; }
