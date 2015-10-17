gitup() {
    if [ $# -ne 2 ]; then
        cat <<EOF
Note:
  add, commit, push
Usage:
  gitup "commit messages"
EOF
    fi

    git add -A
    git status
    ask_ok

    git commit -m "${1}"
    git push -u origin master
}

alias gitzatsu='gitup "雑なコミット"'

gitopen(){
  REPO="$(git remote -v | grep fetch | sed 's/origin//' | tr ':' '/' | sed 's/.*git@/http:\/\//' | sed 's/.git *([a-z]*)//')"
  if [ "$(whereis xdg-open)" ] ; then
    cmd="xdg-open"
  else
    cmd="open"
  fi
  $cmd "$REPO"
}
