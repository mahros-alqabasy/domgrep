#!/bin/bash

run_domgrep() {
    local data

    if [[ -n "${INPUT_FILE:-}" ]]; then
        data=$(cat "$INPUT_FILE")
    else
        data=$(cat)
    fi

    if $USE_REGEX; then
        echo "$data" | grep -E "$PATTERN"
    else
        echo "$data" | grep -F "$PATTERN"
    fi
}
