#!/bin/bash

show_help() {
    cat <<EOF
Usage: domgrep [OPTIONS] PATTERN [FILE]

Search for domain names matching a pattern (regex or plain text).

Options:
  -r, --regex         Use pattern as regular expression
  -f, --file FILE     Read input from a file instead of stdin
  -h, --help          Show this help message
  -v, --version       Show tool version

EOF
    exit 0
}

show_version() {
    echo "domgrep v1.0.0"
    exit 0
}

parse_args() {
    # Default settings
    USE_REGEX=false
    INPUT_FILE=""

    while [[ $# -gt 0 ]]; do
        case $1 in
            -r|--regex) USE_REGEX=true ;;
            -f|--file) INPUT_FILE="$2"; shift ;;
            -h|--help) show_help ;;
            -v|--version) show_version ;;
            *) PATTERN="$1"; shift; break ;;
        esac
        shift
    done

    REMAINING_ARGS=("$@")
}
