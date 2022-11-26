#!/bin/bash
#
# Description
#    make toc (table of contents) using bash
#
# Usage:
#    bash md-toc.sh
#
set -euo pipefail

: << '#COMMENT'
Setting parameters.
Users can change these values via options.
#COMMENT
DEFAULT_INDENT_SIZE=2
DEFAULT_MIN_LEVEL=1
DEFAULT_MAX_LEVEL=9
indent_size="$DEFAULT_INDENT_SIZE"
min_level="$DEFAULT_MIN_LEVEL"
max_level="$DEFAULT_MAX_LEVEL"

# ===== print error =====
function print_error() {
    ERROR='\033[1;31m'
    NORMAL='\033[0m'
    echo -e "${ERROR}ERROR${NORMAL}: $1"
}

PROGRAM="$(basename "$0")"

# ===== print usage =====
function print_usage() {
    echo "Usage: $PROGRAM [OPTION] FILE"
    echo "  -h, --help, -help"
    echo "      print manual"
    echo "  -s <indent_size>, --indent-size <indent_size>"
    echo "      change size of each indent"
    echo "      the default is set to $DEFAULT_INDENT_SIZE."
    echo "  -min <block_size>, --minimum <block_size>"
    echo "      minimum block size of outputs."
    echo "      block size under this number is not shown in outputs."
    echo "      the default is set to $DEFAULT_MIN_LEVEL."
    echo "  -max <block_size>, --maxmum <block_size>"
    echo "      minimaxmummum block size of outputs."
    echo "      block size over this number is not shown in outputs."
    echo "      the default is set to $DEFAULT_MAX_LEVEL."
}

function usage_and_exit() {
    print_usage
    exit "$1"
}

FILE=""
# ===== parse arguments =====
for i in "$@"; do
    case $i in
    -h | --help | -help)
        usage_and_exit 0
        ;;
    -s | --indent-size)
        if [[ -z "$2" ]]; then
            print_error "option requires a indent size -- $1"
            echo ""
            usage_and_exit 1
        fi
        indent_size="$2"
        shift 2
        ;;
    -min | --minimum)
        if [[ -z "$2" ]]; then
            print_error "option requires a indent size -- $1"
            echo ""
            usage_and_exit 1
        fi
        min_level="$2"
        shift 2
        ;;
    -max | --maximum)
        if [[ -z "$2" ]]; then
            print_error "option requires a indent size -- $1"
            echo ""
            usage_and_exit 1
        fi
        max_level="$2"
        shift 2
        ;;
    -*)
        print_error "Unknown option $1"
        echo ""
        usage_and_exit 1
        ;;
    *)
        if [[ "$#" == 0 ]]; then
            continue
        fi
        # If no - or -- prefix is given, 
        # default option is the target file name.
        if [[ -n "$1" ]] && [[ -f "$1" ]]; then
            FILE="$1"
            shift 1
        fi
        ;;
    esac
done

# If the file name is not given, exit as a error.
if [ ! -f "$FILE" ]; then
    print_error "File $FILE doesn't exist"
    exit 1
fi

: << '#COMMENT'
Flag whether the line is the h-tag block.
False in the following condition(s).
* in the code block
#COMMENT
is_target_sharp=true
# main loop (read file)
while read -r line
do
    # when detect code block
    if [[ "$line" =~ ^.*\`\`\`.* ]]; then
        if [[ "$is_target_sharp" == "true" ]]; then
            is_target_sharp=false
        else
            is_target_sharp=true
        fi
    fi

    # when detect heading
    if [[ "$line" =~ ^(\#+)([ ]+)([^\#]*) ]]; then
        if [[ "$is_target_sharp" == "false" ]]; then
            continue
        fi

        block_level="$(echo -n "${BASH_REMATCH[1]}" | wc -c | xargs)"
        title="${BASH_REMATCH[3]}"
        # in the link, space should not be used.
        link="$(echo "$title" | sed -e 's/　/ /g' | tr ' ' '-' | tr '[:upper:]' '[:lower:]')"

        # Decide the indent size of the output.
        extra_space=""
        i=1
        while [[ $i < "$block_level" ]]
        do
            j=0
            while [[ $j < "$indent_size" ]]
            do
                if ((min_level <= i)) && ((i <= max_level)); then
                    extra_space+=" "
                fi
                j=$((j + 1))
            done
            i=$((i + 1))
        done

        if ((min_level <= block_level)) && ((block_level <= max_level)); then
            echo "$extra_space* [$title](#$link)"
        fi
    fi
done < "$FILE"
