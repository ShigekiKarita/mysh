# convert extension
mv_ext() {
    for nm in *.${1}; do
        mv $nm ${nm%.${1}}.${2};
    done
}

# ffmpeg required
flac2mp3() {
    1=${1:-"128"}
    2=${2:-"*.flac"}

    find . -name "*.flac" -exec ffmpeg -i {} -ab ${1}k {}.mp3 \;
    mv_ext flac.mp3 mp3 # fix extension
}

dirsize() {
    1=${1:-"."}
    du -s $1/* | sort -rn
}
