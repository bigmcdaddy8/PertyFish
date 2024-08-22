#!/bin/bash

#
# Requirements:
# Given a input file that contains records in the following format...
# 7k/8/8/8/8/8/7B/K6R w - - c0 "0 additional move(s) specified, up to 5 random move(s) will be created, halfmove and fullmove will be set to default values"
# 7k/8/8/8/8/8/7B/K6R w - - pacn h2e5; c0 "1 additional move(s) specified, up to 4 random move(s) will be created, halfmove and fullmove will be set to default values"
# 7k/8/8/8/8/8/7B/K6R w - - san Be5+ Kg8; c0 "2 additional move(s) specified, up to 3 random move(s) will be created, halfmove and fullmove will be set to default values"
# 7k/8/8/8/8/8/7B/K6R w - - san Be5+ Kg8 Rh8+; c0 "3 additional move(s) specified, up to 2 random move(s) will be created, halfmove and fullmove will be set to default values"
# 7k/8/8/8/8/8/7B/K6R w - - san Be5+ Kg8 Rh8+ Kf7; c0 "4 additional move(s) specified, up to 1 random move(s) will be created, halfmove and fullmove will be set to default values"
# 7k/8/8/8/8/8/7B/K6R w - - san Be5+ Kg8 Rh8+ Kf7 Rh7+; c0 "5 additional move(s) specified, 0 random move(s) will be created, halfmove and fullmove will be set to default values"
# 2R4k/1R1P4/8/8/2r5/8/8/K7 b - - san Rxc8 dxc8=Q# ; c0 "2 additional move(s) specified, 0 random move(s) created due to checkmate, halfmove and fullmove will be set to default values"
# 7k/6p1/8/7P/8/8/8/7K b - - hmvc 5 ; san g5 hxg6 Kg7 ; c0 "3 additional move(s) specified, up to 2 random move(s) will be created, halfmove set to 5 and fullmove will be set to default values"
# 7k/6p1/8/5P1P/8/8/8/7K b - - fmvn 55 ; san g5 fxg6 ; c0 "2 additional move(s) specified, up to 3 random move(s) will be created, halfmove  will be set to default values and fullmove set to 55"
# k5B1/r7/8/8/p7/8/1P6/K7 w - - hmvc 25 ; fmvn 55 ; san b4 axb3+ Kb1 Rg7 ; c0 "4 additional move(s) specified, up to 1 random move(s) will be created, halfmove set to 25 and fullmove set to 55"
# R3k3/8/1R6/8/7p/8/8/4K3 b - - san Ke7 Ra7+ Kd8 Rb8# ; c0 "4 additional move(s) specified, 0 random move(s) will be created due to checkmate, halfmove and fullmove will be set to default values"
# 4kr2/8/8/8/6pP/8/8/4K3 b - h3 0 1 ; san gxh3 ; c0 "1 additional move(s) specified, up to 4 random move(s) will be created due to checkmate, halfmove and fullmove will be set to default values"
# r3k2r/8/8/8/8/8/8/R3K2R w KQkq - ; san O-O ; c0 "1 additional move(s) specified, up to 4 random move(s), halfmove and fullmove will be set to default values"
#
# A test record will be created for each input line, the test record will use the FEN as the starting point (move #0) and will use any additional moves as moves 1-5, depending upon how
# many specified. If less than 5 additional moves are specified this script will create generate random moves so that potenially 5 moves will be specified for each test. In the case that a move is a checkmate
# or a stalemate then no more random moves will be genereated. Therefore it is possible for a test to have less than 5 moves all together.
#
# For the initial position and each additional or random move up to 5 this script will also calculate the number of legal moves for depths of 1-5, along with
# the number of checks, checkmate status, and stalemate status.
#
# stockfish is used as the source of truth
#

BASENAME="`basename $0 ".sh"`"
BASENAME_sh="`basename $0`"

STDERR_FILE="/tmp/${BASENAME}.stderr"



if [[ $# != 1 ]]
then
    echo "USAGE: $0 <record type> " 1>&2
    echo "where record type is:" 1>&2
    echo "0 => for all of the M8Custom.epd tests" 1>&2
    echo "1 => for all of the perft.epd tests (175 of them)" 1>&2
    echo "2 => for the first 200 perft-marcel tests" 1>&2
    echo "3 => for the first 200 ferdy single check tests from file #1 of 19" 1>&2
    echo "4 => for the first 200 ferdy enpassant tests" 1>&2
    echo "5 => for the first 200 ferdy double check tests" 1>&2
    exit 1
fi

REQ_TYPE=$1

exec 2>${STDERR_FILE}

N0="M8Custom"                       # custom
N1="perft"                          # standard
N2="perft-marcel"                   # marcel
N3="ferdy_perft_single_check_1"     # check
N4="ferdy_perft_enpassant_1"        # en passant
N5="ferdy_perft_double_checks"      # checks

case "${REQ_TYPE}" in 
0)  N=${N0}
    TNUM=1000000
    ;;
1)  N=${N1}
    TNUM=2000000
    ;;
2)  N=${N2}
    TNUM=3000000
    ;;
3)  N=${N3}
    TNUM=4000000
    ;;
4)  N=${N4}
    TNUM=5000000
    ;;
*)  N=${N5}
    TNUM=6000000
    ;;
esac

S=`date '+ %s'`
RANDOM=$(( $S % $$ ))

./createFilteredFiles.sh

MAX_NUM_TESTS=200
SUF="${N}.1to${MAX_NUM_TESTS}"
TPLATE_FILE="stockfish_${SUF}_template.txt"
IFILE="filtered01.${N}.epd"
OFILE="${SUF}.M8TestRecords.txt"

if [[ -f /tmp/${OFILE} ]]
then
    rm -f /tmp/${OFILE}
fi

if [[ -f /tmp/${OFILE}.tmp ]]
then
    rm -f /tmp/${OFILE}.tmp
fi

DESC="extended ${SUF} test"

DIR1="../data/raw_inputFiles"
DIR2="../data/filteredFiles"
DIR3="../data/M8TestRecords"

SF="/c/REPOs/stockfish/stockfish-windows-x86-64-avx2.exe"
SF_REFORMAT="./sf_reformat.sh"
PACN2SAN="./pacn2san.sh"
SAN2PACN="./san2pacn.sh"

TPLATE="{
    testNumber:TNUM,
    // Move 0
    FEN_POST_M0:\"M0_POST_FEN\",
    CHECKERS_M0:M0_CHECKS,CHECKMATE_M0:M0_CHECKMATE,STALEMATE_M0:M0_STALEMATE,
    NODES_M0_D1:M0_NODES_D1,
    // Move 1
    SAN_M1:\"M1_SAN\", PACN_M1:\"M1_PACN\",
    FEN_POST_M1:\"M1_POST_FEN\",
    CHECKERS_M1:M1_CHECKS,CHECKMATE_M1:M1_CHECKMATE,STALEMATE_M1:M1_STALEMATE,
    NODES_M1_D1:M1_NODES_D1,
    // Move 2
    SAN_M2:\"M2_SAN\", PACN_M2:\"M2_PACN\",
    FEN_POST_M2:\"M2_POST_FEN\",
    CHECKERS_M2:M2_CHECKS,CHECKMATE_M2:M2_CHECKMATE,STALEMATE_M2:M2_STALEMATE,
    NODES_M2_D1:M2_NODES_D1,
    // Move 3
    SAN_M3:\"M3_SAN\", PACN_M3:\"M3_PACN\",
    FEN_POST_M3:\"M3_POST_FEN\",
    CHECKERS_M3:M3_CHECKS,CHECKMATE_M3:M3_CHECKMATE,STALEMATE_M3:M3_STALEMATE,
    NODES_M3_D1:M3_NODES_D1,
    // Move 4
    SAN_M4:\"M4_SAN\", PACN_M4:\"M4_PACN\",
    FEN_POST_M4:\"M4_POST_FEN\",
    CHECKERS_M4:M4_CHECKS,CHECKMATE_M4:M4_CHECKMATE,STALEMATE_M4:M4_STALEMATE,
    NODES_M4_D1:M4_NODES_D1,
    // Move 5
    SAN_M5:\"M5_SAN\", PACN_M5:\"M5_PACN\",
    FEN_POST_M5:\"M5_POST_FEN\",
    CHECKERS_M5:M5_CHECKS,CHECKMATE_M5:M5_CHECKMATE,STALEMATE_M5:M5_STALEMATE,
    NODES_M5_D1:M5_NODES_D1,
    // Results
    testResultStr:\"\",testFinished:false,testPassed:false,description:\"XXX_DESC\"
},"

SF_COMMANDS="/tmp/generic_stockfishCommands.txt"

cat <<- EOF >${SF_COMMANDS}
    ucinewgame
    position fen FEN MOVE
    d
    go perft 1
    go perft 2
    quit
EOF

grep -v '^#' ${DIR2}/${IFILE} | grep -v '^$' | head -${MAX_NUM_TESTS} | while read epd
do
    printf "DEBUG: %s ##### start of new test #########################################################################################\n" ${BASENAME_sh}  1>&2
    printf "DEBUG: %s EPD INPUT RECORD: %s\n" ${BASENAME_sh} "${epd}" 1>&2
    printf "DEBUG: %s TNUM: %d\n" ${BASENAME_sh} ${TNUM} 1>&2

    FEN_M0="`echo "${epd}" | cut -d' ' -f1-4`" # <Piece Placement> <Side to move> <Castling ability> <En passant target square> 
    HM="`echo ${epd} | awk '
        / hmvc / {
            i = match($0, / hmvc ([0-9]{1,}) ; /, arr)
            if (i > 0) {
                printf("%d", arr[1])
                hmvcFound=1
            }
        }
        END {
            if (! hmvcFound) {
                printf("0")
            }
        }'`"
    FM="`echo ${epd} | awk '
        / fmvn / {
            i = match($0, / fmvn ([0-9]{1,}) ; /, arr)
            if (i > 0) {
                printf("%d", arr[1])
                fmvnFound=1
            }
        }
        END {
            if (! fmvnFound) {
                printf("1")
            }
        }'`"

    FEN_M0="${FEN_M0} ${HM} ${FM}"
    printf "DEBUG: %s FEN_M0: %s\n" "${BASENAME_sh}" "${FEN_M0}" 1>&2
    
    # san Rxc8 dxc8=Q# f4 e5; # optional - might not be there 
    # pacn c1c8 d7c8=q f5f4 e4e5; # optional - might not be there
    ADDITIONAL_PACNS_STR="`echo ${epd} | grep ' pacn ' | sed -e 's/^.* pacn //' | sed -e 's/ ; .*$//'`"
    printf "DEBUG: %s FEN_M0: %s ADDITIONAL_PACNS_STR:%s:\n" ${BASENAME_sh} "${FEN_M0}" "${ADDITIONAL_PACNS_STR}" 1>&2
    if [[ $ADDITIONAL_PACNS_STR == "" ]]
    then
        ADDITIONAL_SANS_STR="`echo ${epd} | grep ' san ' | sed -e 's/^.* san //' | sed -e 's/ ; .*$//'`"
        printf "DEBUG: %s FEN_M0: %s ADDITIONAL_SANS_STR:%s:\n" ${BASENAME_sh} "${FEN_M0}" "${ADDITIONAL_SANS_STR}" 1>&2
        if [[ $ADDITIONAL_SANS_STR == "" ]]
        then
            ADDITIONAL_MOVES_COUNT=0
        else
            ADDITIONAL_MOVES_COUNT=`echo ${ADDITIONAL_SANS_STR} | awk '{ print NF }'`

            FEN_TMP="${FEN_M0}"

            for (( c=1; c <= ADDITIONAL_MOVES_COUNT; c++ ))
            do
                SAN="`echo ${ADDITIONAL_SANS_STR} | cut -d' ' -f${c}`"
                PACN=`${SAN2PACN} "${FEN_TMP}" "${SAN}"`

                printf "DEBUG: %s SAN2PACN converted SAN: %s to PACN: %s FEN_TMP: %s\n" "${BASENAME_sh}" "${SAN}" "${PACN}" "${FEN_TMP}" 1>&2

                awk -v FEN="${FEN_TMP}" -v MOVE="${PACN}" '
                {
                    gsub(/FEN/, FEN)
                    if (MOVE && MOVE != "") { 
                        gsub(/MOVE/, "moves " MOVE)
                    }
                    else {
                        gsub(/MOVE/, "")
                    }
                    print $0
                }' ${SF_COMMANDS} > /tmp/FEN_TMP_stockfishInput.txt

                ${SF} >/tmp/FEN_TMP_stockfishOutput.txt </tmp/FEN_TMP_stockfishInput.txt
                ${SF_REFORMAT} /tmp/FEN_TMP_stockfishOutput.txt > /tmp/FEN_TMP_stockfishOutputReformatted.txt

                printf "DEBUG: %s FEN_TMP: %s c: %d converted SAN: %s -> PACN: %s\n" "${BASENAME_sh}" "${FEN_TMP}" ${c} "${SAN}" "${PACN}" 1>&2

                ADDITIONAL_PACNS_ARR[${c}]="${PACN}"
                ADDITIONAL_SANS_ARR[${c}]="${SAN}"
                FEN_TMP="`grep '^FEN:' /tmp/FEN_TMP_stockfishOutputReformatted.txt | cut -d':' -f2`"
                printf "DEBUG: %s NEXT FEN_TMP: %s\n" ${BASENAME_sh} "${FEN_TMP}" 1>&2
            done
        fi
    else
        ADDITIONAL_MOVES_COUNT=`echo ${ADDITIONAL_PACNS_STR} | awk '{ print NF }'`

        FEN_TMP="${FEN_M0}"

        for (( c=1; c <= ADDITIONAL_MOVES_COUNT; c++ ))
        do
            PACN="`echo ${ADDITIONAL_PACNS_STR} | cut -d' ' -f${c}`"
            SAN=`${PACN2SAN} "${FEN_M0}" ${PACN}`

            printf "DEBUG: %s PACN2SAN converted PACN: %s to SAN: %s FEN: %s\n" "${BASENAME_sh}" "${FEN_M0}" "${PACN}" "${SAN}" 1>&2

            awk -v FEN="${FEN_TMP}" -v MOVE="${PACN}" '
            {
                gsub(/FEN/, FEN)
                if (MOVE && MOVE != "") {
                    gsub(/MOVE/, "moves " MOVE)
                }
                else {
                    gsub(/MOVE/, "")
                }
                print $0
            }' ${SF_COMMANDS} > /tmp/FEN_TMP_stockfishInput.txt

            ${SF} >/tmp/FEN_TMP_stockfishOutput.txt </tmp/FEN_TMP_stockfishInput.txt
            ${SF_REFORMAT} /tmp/FEN_TMP_stockfishOutput.txt > /tmp/FEN_TMP_stockfishOutputReformatted.txt

            ADDITIONAL_PACNS_ARR[${c}]="${PACN}"
            ADDITIONAL_SANS_ARR[${c}]="${SAN}"
            FEN_TMP="`grep '^FEN:' /tmp/FEN_TMP_stockfishOutputReformatted.txt | cut -d':' -f2`"
            printf "DEBUG: %s NEXT FEN_TMP: %s\n" ${BASENAME_sh} "${FEN_TMP}" 1>&2
        done
    fi

    for (( c=0; c <= ADDITIONAL_MOVES_COUNT; c++ ))
    do
        printf "DEBUG: %s move array dump -> c=%d ADDITIONAL_MOVES_COUNT: %d ADDITIONAL_PACNS_ARR[%d]: %s ADDITIONAL_SANS_ARR[%d]: %s\n" \
            ${BASENAME_sh} $c ${ADDITIONAL_MOVES_COUNT} $c "${ADDITIONAL_PACNS_ARR[$c]}" $c "${ADDITIONAL_SANS_ARR[$c]}" 1>&2
    done

    echo "${TPLATE}" | awk -v TNUM="${TNUM}" '{
        gsub(/TNUM/, TNUM);  
        print $0
    }' >/tmp/${OFILE}.tmp

    PRE_MOVE_FEN="${FEN_M0}"

    for MNUM in {0..5}
    do
        cp /tmp/${OFILE}.tmp /tmp/stockfish_${SUF}_M${MNUM}_testRecord.txt 

        if [[ $MNUM -le $ADDITIONAL_MOVES_COUNT ]]
        then
            CURRENT_MOVE_PACN="${ADDITIONAL_PACNS_ARR[${MNUM}]}"
            CURRENT_MOVE_SAN="${ADDITIONAL_SANS_ARR[${MNUM}]}"
        else
            CURRENT_MOVE_PACN="${POST_MOVE_RANDOM_NEXT_MOVE_PACN}"
            CURRENT_MOVE_SAN="${POST_MOVE_RANDOM_NEXT_MOVE_SAN}"
        fi

        printf "DEBUG: %s  MNUM loop: %d ADDITIONAL_MOVES_COUNT: %d CURRENT_MOVE_PACN: %s CURRENT_MOVE_SAN: %s\n" \
            ${BASENAME_sh} ${MNUM} ${ADDITIONAL_MOVES_COUNT} "${CURRENT_MOVE_PACN}" "${CURRENT_MOVE_SAN}" 1>&2

        awk -v FEN="${PRE_MOVE_FEN}" -v MOVE="${CURRENT_MOVE_PACN}" '
        {
            gsub(/FEN/, FEN)
            if (MOVE && MOVE != "") {
                gsub(/MOVE/, "moves " MOVE)
            }
            else {
                gsub(/MOVE/, "")
            }
            print $0
        }' ${SF_COMMANDS} > /tmp/stockfish_${SUF}_M${MNUM}_stockfishInput.txt

        ${SF} >/tmp/stockfish_${SUF}_M${MNUM}_stockfishOutput.txt </tmp/stockfish_${SUF}_M${MNUM}_stockfishInput.txt
        ${SF_REFORMAT} /tmp/stockfish_${SUF}_M${MNUM}_stockfishOutput.txt > /tmp/stockfish_${SUF}_M${MNUM}_stockfishOutputReformatted.txt

        POST_MOVE_FEN="`grep '^FEN:' /tmp/stockfish_${SUF}_M${MNUM}_stockfishOutputReformatted.txt | cut -d':' -f2`"
        POST_MOVE_CHECKS="`grep '^CHECKS:' /tmp/stockfish_${SUF}_M${MNUM}_stockfishOutputReformatted.txt | cut -d':' -f2`"
        POST_MOVE_NUM_CHECKS="`grep '^NUM_CHECKS:' /tmp/stockfish_${SUF}_M${MNUM}_stockfishOutputReformatted.txt | cut -d':' -f2`"
        POST_MOVE_CHECKMATE="`grep '^CHECKMATE:' /tmp/stockfish_${SUF}_M${MNUM}_stockfishOutputReformatted.txt | cut -d':' -f2`"
        POST_MOVE_STALEMATE="`grep '^STALEMATE:' /tmp/stockfish_${SUF}_M${MNUM}_stockfishOutputReformatted.txt | cut -d':' -f2`"
        POST_MOVE_NODESD1="`grep '^NODE_COUNT\[1\]:' /tmp/stockfish_${SUF}_M${MNUM}_stockfishOutputReformatted.txt | cut -d':' -f2`"
        POST_MOVE_RANDOM_NEXT_MOVE_PACN="`grep '^RANDOM_PACN:' /tmp/stockfish_${SUF}_M${MNUM}_stockfishOutputReformatted.txt | cut -d':' -f2`"
        if [[ ${POST_MOVE_RANDOM_NEXT_MOVE_PACN} == "" ]]
        then
            POST_MOVE_RANDOM_NEXT_MOVE_SAN=""
        else
            POST_MOVE_RANDOM_NEXT_MOVE_SAN="`${PACN2SAN} "${POST_MOVE_FEN}" ${POST_MOVE_RANDOM_NEXT_MOVE_PACN}`"
        fi

        printf "DEBUG: %s POST_MOVE_FEN: %s\n" ${BASENAME_sh} "${POST_MOVE_FEN}" 1>&2
        printf "DEBUG: %s POST_MOVE_CHECKS: %s\n" ${BASENAME_sh} "${POST_MOVE_CHECKS}" 1>&2
        printf "DEBUG: %s POST_MOVE_NUM_CHECKS: %s\n" ${BASENAME_sh} ${POST_MOVE_NUM_CHECKS} 1>&2
        printf "DEBUG: %s POST_MOVE_CHECKMATE: %s\n" ${BASENAME_sh} ${POST_MOVE_CHECKMATE} 1>&2
        printf "DEBUG: %s POST_MOVE_STALEMATE: %s\n" ${BASENAME_sh} ${POST_MOVE_STALEMATE} 1>&2
        printf "DEBUG: %s POST_MOVE_NODESD1: %s\n" ${BASENAME_sh} ${POST_MOVE_NODESD1} 1>&2
        printf "DEBUG: %s POST_MOVE_RANDOM_NEXT_MOVE_PACN: %s\n" ${BASENAME_sh} ${POST_MOVE_RANDOM_NEXT_MOVE_PACN} 1>&2
        printf "DEBUG: %s POST_MOVE_RANDOM_NEXT_MOVE_SAN: %s\n" ${BASENAME_sh} ${POST_MOVE_RANDOM_NEXT_MOVE_SAN} 1>&2

        printf "DEBUG: %s rep template write - MNUM: %d PRE_MOVE_FEN: %s POST_MOVE_FEN: %s\n" ${BASENAME_sh} ${MNUM} "${PRE_MOVE_FEN}" "${POST_MOVE_FEN}" 1>&2

        awk -v M="${MNUM}" -v SAN="${CURRENT_MOVE_SAN}" -v PACN="${CURRENT_MOVE_PACN}" -v FEN_POST_MOVE="${POST_MOVE_FEN}" -v CHECKS="${POST_MOVE_CHECKS}" -v CHECKMATE="${POST_MOVE_CHECKMATE}" -v DESC="${DESC}" \
            -v STALEMATE="${POST_MOVE_STALEMATE}" -v NODESD1="${POST_MOVE_NODESD1}" '
        {
            if (M > 0) {
                gsub("M" M "_SAN", SAN); gsub("M" M "_PACN", PACN);
            }
            gsub("M" M "_POST_FEN", FEN_POST_MOVE);
            if (CHECKS == "") {
                gsub("M" M "_CHECKS", "\"\"");
            }
            else {
                gsub("M" M "_CHECKS", CHECKS);
            }
            gsub("M" M "_CHECKMATE", CHECKMATE);  gsub("M" M "_STALEMATE", STALEMATE); gsub(/XXX_DESC/, DESC);
            gsub("M" M "_NODES_D1", NODESD1); 
            print $0
        }' /tmp/stockfish_${SUF}_M${MNUM}_testRecord.txt | sed -e 's/""""/""/g' >/tmp/${OFILE}.tmp

        PRE_MOVE_FEN="${POST_MOVE_FEN}"
        PRE_MOVE_CHECKMATE="${POST_MOVE_CHECKMATE}"
        PRE_MOVE_STALEMATE="${POST_MOVE_STALEMATE}"
    done

    cat /tmp/${OFILE}.tmp >> /tmp/${OFILE}

    (( TNUM = TNUM + 10 ))
done  

NL="`wc -l /tmp/${OFILE} | awk '{ print $1 }'`"
awk -v NL="${NL}" '
NR < NL { print $0 }
NR == NL { 
    sub(/,$/, ""); print $0 
}' /tmp/${OFILE} > /tmp/${OFILE}.tmp

cmp -s /tmp/${OFILE}.tmp ${DIR3}/${OFILE} || cp /tmp/${OFILE}.tmp ${DIR3}/${OFILE}

exit 0






















        





