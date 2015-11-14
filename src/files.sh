# convert extension
mv_ext() {
    for nm in *.${1}; do
        mv $nm ${nm%.${1}}.${2};
    done
}

# require ffmpeg
convert2mp3() {
    1=${1:-"128"}
    2=${2:-"*.flac"}

    find . -name "*.flac" -exec ffmpeg -i {} -ab ${1}k {}.mp3 \;
    mv_ext flac.mp3 mp3 # fix extension
}

dirsize() {
    1=${1:-"."}
    du -s $1/* | sort -rn
}

dirsizes() {
    1=${1:-"."}
    du -s $1/* $1/.* | sort -rn
}


ln_version() {
    src=`ls "${1}" | grep -e "${2}"`
    while read -r line; do
        dst=`echo ${line} | sed s/${2}//g`
        echo "${1}/${line}\n-> ${1}/${dst}"
    done <<< "${src}"

    ask_ok

    while read -r line; do
        dst=`echo ${line} | sed s/${2}//g`
        sudo ln -s "${1}/${line}" "${1}/${dst}"
    done <<< "${src}"
}

wgetpages(){
    wget -r -l1 -w2 --random-wait -p -k $@
}

alias extract="tar -xvf"

archive() {
    filename=$(basename ${1})
    filename=${filename%.*}
    2=${2:-$filename}
    tar -acvf $1 $2
}

findrm() {
    find . -name "${1}"
    ask_ok
    find . -name "${1}" -exec rm -rvf {} \;
}

rm_dropbox_garbage() {
    # TODO show diff neatly
    findrm "*conflicted copy*"
}
