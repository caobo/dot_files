#!/bin/sh
file="$1"
w="$2"
h="$3"
x="$4"
y="$5"

check_cache() {
    if [ ! -d "$HOME/.cache/lf" ]; then
        mkdir -p "$HOME/.cache/lf"
    fi
}

hash_filename() {
    TMP_FILE="$HOME/.cache/lf/$(echo "${1%.*}" | sed -e 's|/|\!|g').$2"
}

draw_clear() {
    kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
}

draw_image() {
    kitty +kitten icat --silent --stdin no --transfer-mode file --place "${w}x${h}@${x}x${y}" "$file" < /dev/null > /dev/tty
    command chafa -f sixel --optimize=9 -s "$2x$3" --animate off --polite on "$1"
}

make_video() {
    if [ "${TMP_FILE}" -ot "$1" ]; then
        ffmpegthumbnailer -t 0% -q 3 -s 0 -c jpeg -i "$1" -o "${TMP_FILE}"
    fi
}

make_pdf() {
    if [ "${TMP_FILE}" -ot "$1" ]; then
        pdftoppm -png -f 1 -l 1 -jpeg -tiffcompression jpeg -scale-to-x -1 -scale-to-y 1080 -singlefile "$1" "${TMP_FILE%.png}"
    fi
}

check_cache
draw_clear

case $(file -b --mime-type "$1") in
    text/*)
        bat --force-colorization --paging=never --style=numbers --terminal-width $(($2 - 5)) -f "$1"
        ;;
    image/*)
        draw_image "$1" "$2" "$3" "$4" "$5"
        exit 1
        ;;
    video/*)
        hash_filename "$1" "jpg"
        make_video "$1" "$2" "$3"
        draw_image "${TMP_FILE}" "$2" "$3" "$4" "$5"
        exit 1
        ;;
    application/pdf)
        hash_filename "$1" "png"
        make_pdf "$1" "$2" "$3"
        draw_image "${TMP_FILE}" "$2" "$3" "$4" "$5"
        exit 1
        ;;
    application/gzip|application/x-xz)
        tar tf "$1"
        ;;
    application/zip)
        unzip -Z -1 "$1"
        ;;
    application/x-sharedlib)
        readelf -h "$1"
        ;;
esac

exit 0

