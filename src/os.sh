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

rg() {
    # for tmux
    $@ < /dev/null >/dev/null 2>/dev/null &
}

alias cowsays='cowsay -l | grep -v "^Cow" | sed -e "s% %\n%g" | sed -e "s%\(.*\)%cowsay -f \1 Now I am a \1%" | sh | less'

alias which_pid='ps aux | grep '

alias manjp='LANG=ja_JP.utf8 man'
