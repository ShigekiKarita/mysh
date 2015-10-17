gitzatsu() {
    git add --all
    git commit -m "雑なコミット"
    git push origin master
}

gitup() {
    git add -A
    git commit -m "${1}"
    git push -u origin master
}

gitopen(){
  REPO="$(git remote -v | grep fetch | sed 's/origin//' | tr ':' '/' | sed 's/.*git@/http:\/\//' | sed 's/.git *([a-z]*)//')"
  if [ "$(whereis xdg-open)" ] ; then
    cmd="xdg-open"
  else
    cmd="open"
  fi
  $cmd "$REPO"
}
