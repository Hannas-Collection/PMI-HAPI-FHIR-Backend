#! /bin/bash
#
# bash-test.sh
#
#
BOLD="\033[1m"
NORMAL="\033[0m"
GREEN="\033[32m"
RED="\033[31m"
GRAY="\033[90m"

export BASE_URL="http://hapi.fhir.org/baseR4"

# bash-test.sh --verbose --url http://localhost/baseR4 src/test/bash/testcases

VERBOSE=0
while [ $# -ge 1 ]; do
    case "$1" in
        -v|--verbose)
            VERBOSE=1
            ;;
        --url)
            BASE_URL="$2"
            shift
            ;;
        *)
            DIR=$1
            ;;
    esac
    shift
done

stdout=$(mktemp)
stderr=$(mktemp)
find "${DIR:-.}" -type f -executable | while read file; do
    echo -en "${BOLD}Testing $file..."
    full_path="$(realpath "$file")"
    "$full_path" > "$stdout" 2> "$stderr"
    failed=$?
    if [ $failed -ne 0 ]; then
        echo -e "${RED}FAILED!${NORMAL}"
    else
        echo -e "${GREEN}OK${NORMAL}"
    fi

    if [ $VERBOSE = 1 ]; then
            echo -e "${GRAY}===== stdout =====${NORMAL}"
            cat "$stdout"
            echo -e "${GRAY}==================${NORMAL}"
    fi
    if [ $VERBOSE = 1 ] || [ $failed -ne 0 ]; then
            echo -e "${GRAY}===== stderr =====${NORMAL}"
            cat "$stderr"
            echo -e "${GRAY}==================${NORMAL}"
    fi

done

rm ${stdout} || :
rm ${stderr} || :
