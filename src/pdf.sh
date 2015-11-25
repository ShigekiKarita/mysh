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

    while read -r line
    do
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
    echo $dirs | parallel convert2pdf {}
    # while read -r line; do
    #     echo "$line"
    #     convert2pdf "$line"
    # done <<< $dirs
}
