# convert extension
mv_ext() {
    for nm in *.${1}; do
        mv $nm ${nm%.${1}}.${2};
    done
}

lns_ext() {
    for nm in *.${1}; do
        ln -s `pwd`/$nm ${nm%.${1}}.${2};
    done
}


# require ffmpeg
convert2mp3() {
    1=${1:-"128"}
    2=${2:-"*.flac"}

    find . -name "*.flac" -exec ffmpeg -i {} -ab ${1}k {}.mp3 \;
    mv_ext flac.mp3 mp3 # fix extension
}

extract_audio() {
    ffmpeg -i $1 -vn -acodec copy $2
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

unar_all() {
    find . -name "${1}" | parallel unar {} \;
}


flv2mp4() {
    find . -name "*.flv" -exec ffmpeg -i {} -c:v libx264 -crf 19 -strict experimental {}.mp4 \;
    mv_ext flv.mp4 mp4 # fix extension
}



alias nkfo='nkf -wLu --overwrite'


# text
find_str() {
    find ${1} -type f -print | xargs grep ${2}
}

replace_str() {
    find ${1} -type f | xargs sed -i 's/${2}/${3}/g'
}


# statistics
average-of() {
    tail -n 42 | sed 's/.*${1}: \?\([0-9\.-]*\).*/\1/' | awk '{ total += $1; count++ } END { print total/count }'
}
