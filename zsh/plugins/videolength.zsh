function videolength() {
    [[ -z "$1" ]] && echo "no input file(s)" >&2 && return 1
    while [[ -n "$1" ]]; do
        ffprobe -i "$1" 2>&1 | \
        grep --color=never --only-matching --perl-regexp "(?<=Duration: ).*?(?=,)" | \
        read duration ; echo -n $duration
        echo "\t$1"
        shift;
    done
}
