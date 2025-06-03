#!/bin/bash
set -euo pipefail

# Source other modules
source "$(dirname "$0")/utils.sh"
source "$(dirname "$0")/parser.sh"

main() {
    parse_args "$@"
    run_domgrep
}

main "$@"
