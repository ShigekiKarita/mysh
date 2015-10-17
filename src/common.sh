ask_ok() {
    echo "Are you ok? [Y/n]"
    read ANSWER

    case $ANSWER in
        "" | "Y" | "y" | "yes" | "Yes" | "YES" ) echo "YES!!";;
        * ) echo "NO!!" && exit 1;;
    esac
}

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
