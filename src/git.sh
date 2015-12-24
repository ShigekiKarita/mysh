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
    git push
}

alias gitzatsu='gitup "雑なコミット"'

# remote repository url をブラウザで開く
gitopen(){
  REPO="$(git remote -v | grep fetch | sed 's/origin//' | tr ':' '/' | sed 's/.*git@/http:\/\//' | sed 's/.git *([a-z]*)//' | head -n 1)"
  if [ "$(whereis xdg-open)" ] ; then
    cmd="xdg-open"
  else
    cmd="open"
  fi
  $cmd "$REPO"
}

alias gitdiff='git diff --color-words --find-renames'
alias gitlog='git log --graph --decorate --oneline'
alias gitlogdiff='gitlog -p --stat --find-renames'
alias gitlogfile='git log --follow'
alias gitdiffname='gitdiff --name-only'
alias gitclone_small='git clone --depth 1 --branch master '
