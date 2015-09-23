#!/usr/bin/env zsh

function usage {
    this=$(basename ${0})
    cat <<EOF
${this} is good

Usage:
    convert2mp3 128 *.flac  ## using ffmpeg to audio files in current dir
    dirsize .  ## survey dir sizes
    pdfinetune *.pdf 400 200 ## refine scanned pdf and convert dpis
EOF
}

ask_ok() {
    echo "Are you ok? [Y/n]"
    read ANSWER

    case $ANSWER in
        "" | "Y" | "y" | "yes" | "Yes" | "YES" ) echo "YES!!";;
        * ) echo "NO!!" && exit 1;;
    esac
}

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

# require imagemagick
pdfinetune() {
    target=${1:-"*.pdf"}
    srcd=${2:-"400"}
    dstd=${3:-"200"}
    mogrify -density $srcd -normalize -level 10%,90% -density $dstd -units PixelsPerInch $target
}

copy_pdfs() {
    if [ $# -ne 2 ]; then
        cat <<EOF
Note:
cp_bibpdf copys PDFs described in Mendeley's bibtex
Usage:
    cp_bibpdf {src.bib} {dst_dir}
EOF
        exit 1
    fi

    files=`grep -e "pdf" $1  \
         | sed 's/^file = {://g' \
         | sed 's/:pdf},//g'     \
         | sed 's/\(.*\)/\/\1/g'`

    while read -r line; do
        echo "$line"
        cp $line $2
    done <<< "$files"
}

convert2pdf() {
    ext=${2:-"jpg"}
    dst=${3:-$1}
    echo convert "${1}/*.${ext}" "${dst}.pdf"
    convert "${1}/*.${ext}" "${dst}.pdf"
}

convert2pdf_all() {
    dirs=` ls -F | grep / | sed 's/\(.*\)/\1/g' | sed 's/\(.*\)\//\1/g'`
    while read -r line; do
        echo "$line"
        convert2pdf "$line"
    done <<< $dirs
}

gitzatsu() {
    git add --all
    git commit -m "雑なコミット"
    git push origin master
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

alias turnoff='xset dpms force off'
alias turnon='xset dpms force on'
