alias turnoff='xset dpms force off'
alias turnon='xset dpms force on'

alias em='emacsclient -nw -a "" -t'
alias emx='emacsclient -a "" -nc'
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias caps2ctrl='setxkbmap -option ctrl:nocaps'
alias open=xdg-open
export EDITOR=emacs

alias reset-mouse='sudo modprobe -r psmouse &&  sudo modprobe psmouse'
alias reset-keyboard='setxkbmap -rules evdev -model jp106 -layout jp'
