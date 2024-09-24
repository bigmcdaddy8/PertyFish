#!/bin/bash

#
# Requirements:
# Given a input file that contains records with correctly formatted FEN such as...
# r1bqr1k1/5pb1/p6p/Pp1P2p1/2N1n3/8/1P2B1PP/R2QBR1K w - b6 0 1
# r1bqr1k1/5pb1/p6p/Pp1P2p1/2N1n3/8/1P2B1PP/R2QBR1K w - - 0 1
# r1bqr1k1/5pb1/p6p/Pp1P2p1/2N1n3/8/1P2B1PP/R2QBR1K w - - -
# r1bqr1k1/5pb1/p6p/Pp1P2p1/2N1n3/8/1P2B1PP/R2QBR1K w - - 
#
# The output file will contain the original FEN plus the following -> "; D1 X"
#   - where X will be a integer representing the number of legal moves that can be made at a depth level of 1 according to stockfish
#
#

BASENAME="`basename $0 ".sh"`"
BASENAME_sh="`basename $0`"

STDERR_FILE="/tmp/${BASENAME}.stderr"



if [[ $# != 1 ]]
then
    echo "USAGE: $0 <record type> " 1>&2
    echo "where record type is:" 1>&2
    echo "1 => for all of the perft.epd tests (175 of them)" 1>&2
    echo "2 => for the first 200 perft-marcel tests" 1>&2
    echo "3 => for the first 200 ferdy single check tests from file #1 of 19" 1>&2
    echo "4 => for the first 200 ferdy enpassant tests" 1>&2
    echo "5 => for the first 200 ferdy double check tests" 1>&2
    exit 1
fi

REQ_TYPE=$1

exec 2>${STDERR_FILE}

N1="perft"                          # standard
N2="perft-marcel"                   # marcel
N3="ferdy_perft_single_check_1"     # check
N4="ferdy_perft_enpassant_1"        # en passant
N5="ferdy_perft_double_checks"      # checks

usage() {
    echo "usage: $0 <REQ_TYPE>" 1>&2
}

case "${REQ_TYPE}" in 
1)  N=${N1}
    ;;
2)  N=${N2}
    ;;
3)  N=${N3}
    ;;
4)  N=${N4}
    ;;
5)  N=${N5}
    ;;
*)  usage
    exit 1
    ;;
esac

S=`date '+ %s'`
RANDOM=$(( $S % $$ ))

./createFilteredFiles.sh

SUF="${N}"
TPLATE_FILE="stockfish_${SUF}_template.txt"
IFILE="filtered01.${N}.epd"
OFILE="${SUF}.PertyFish.epd"

if [[ -f /tmp/${OFILE} ]]
then
    rm -f /tmp/${OFILE}
fi

if [[ -f /tmp/${OFILE}.tmp ]]
then
    rm -f /tmp/${OFILE}.tmp
fi

DESC="extended ${SUF} test"

DIR1="../data/EPD_files"
DIR2="../data/filteredFiles"
DIR3="../data/PertyFish_D1_EPD"

SF="/c/REPOs/stockfish/stockfish-windows-x86-64-avx2.exe"
SF_REFORMAT="./sf_reformat.sh"

SF_COMMANDS="/tmp/generic_stockfishCommands.txt"

cat <<- EOF >${SF_COMMANDS}
    ucinewgame
    position fen FEN
    go perft 1
    quit
EOF

grep -v '^#' ${DIR2}/${IFILE} | grep -v '^$' | while read epd
do
    awk -v FEN="${epd}" '
    {
        gsub(/FEN/, FEN)
        print $0
    }' ${SF_COMMANDS} > /tmp/stockfish_${SUF}_stockfishInput.txt

    ${SF} >/tmp/stockfish_${SUF}_stockfishOutput.txt </tmp/stockfish_${SUF}_stockfishInput.txt

    NUM_MOVES="`grep '^Nodes searched:' /tmp/stockfish_${SUF}_stockfishOutput.txt | cut -d':' -f2 | awk '{ gsub(/ /, ""); print $0 }'`"

    echo "${epd} ; D1 ${NUM_MOVES}"
done > /tmp/${OFILE}

cmp -s /tmp/${OFILE} ${DIR3}/${OFILE} || cp /tmp/${OFILE} ${DIR3}/${OFILE}

exit 0






















        





