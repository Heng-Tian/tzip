#!/usr/bin/env bash
# tzip / tunzip - tar + pigz + pv helpers
# Author: Heng Tian
# Usage: source tzip.sh

tzip() {
    if [ $# -lt 1 ]; then
        echo "Usage: tzip <folder> [output_file] [-p <threads>]"
        return 1
    fi

    local input_dir=""
    local output_file=""
    local threads=$(nproc)
    local next_is_p=false

    for arg in "$@"; do
        if [ "$next_is_p" = true ]; then
            threads="$arg"
            next_is_p=false
            continue
        fi
        case "$arg" in
            -p) next_is_p=true ;;
            *)
                if [ -z "$input_dir" ]; then
                    input_dir="$arg"
                elif [ -z "$output_file" ]; then
                    output_file="$arg"
                fi
                ;;
        esac
    done

    if [ ! -d "$input_dir" ]; then
        echo "Error: '$input_dir' is not a directory."
        return 1
    fi

    if [ -z "$output_file" ]; then
        output_file="${input_dir%/}.tar.gz"
    fi

    local tmp_file="${output_file}.tmp"
    local total_size=$(du -sb "$input_dir" | awk '{print $1}')

    tar cf - "$input_dir" \
        | pv -s "$total_size" \
        | pigz -p "$threads" > "$tmp_file" \
        && mv "$tmp_file" "$output_file"
}

tunzip() {
    if [ $# -lt 1 ]; then
        echo "Usage: tunzip <archive> [target_dir]"
        return 1
    fi

    local archive="$1"
    local target_dir="${2:-.}"

    local total_size=$(du -sb "$archive" | awk '{print $1}')

    pv -s "$total_size" "$archive" | pigz -d | tar xf - -C "$target_dir"
}
