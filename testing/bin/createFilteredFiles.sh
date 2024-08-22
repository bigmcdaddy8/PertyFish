#!/bin/bash

D1="../data/raw_inputFiles"
D2="../data/filteredFiles"

F0="M8Custom.epd"
F1="perft.epd"
F2="perft-marcel.epd"
F3="ferdy_perft_single_check_1.epd"
F4="ferdy_perft_enpassant_1.epd"
F5="ferdy_perft_double_checks.epd"

cat ${D1}/${F0} | tr -d '\0' | grep -v '^ *#' | grep -v '^$' > /tmp/filtered01.${F0}
cat ${D1}/${F1} | tr -d '\0' | grep -v '^ *#' | grep -v '^$' > /tmp/filtered01.${F1}
cat ${D1}/${F2} | tr -d '\0' | grep -v '^ *#' | grep -v '^$' > /tmp/filtered01.${F2}
cat ${D1}/${F3} | tr -d '\0' | grep -v '^ *#' | grep -v '^$' > /tmp/filtered01.${F3}
cat ${D1}/${F4} | tr -d '\0' | grep -v '^ *#' | grep -v '^$' > /tmp/filtered01.${F4}
cat ${D1}/${F5} | tr -d '\0' | grep -v '^ *#' | grep -v '^$' > /tmp/filtered01.${F5}

cmp -s /tmp/filtered01.${F0} ${D2}/filtered01.${F1} || cp /tmp/filtered01.${F0} ${D2}/filtered01.${F0}
cmp -s /tmp/filtered01.${F1} ${D2}/filtered01.${F1} || cp /tmp/filtered01.${F1} ${D2}/filtered01.${F1}
cmp -s /tmp/filtered01.${F2} ${D2}/filtered01.${F2} || cp /tmp/filtered01.${F2} ${D2}/filtered01.${F2}
cmp -s /tmp/filtered01.${F3} ${D2}/filtered01.${F3} || cp /tmp/filtered01.${F3} ${D2}/filtered01.${F3}
cmp -s /tmp/filtered01.${F4} ${D2}/filtered01.${F4} || cp /tmp/filtered01.${F4} ${D2}/filtered01.${F4}
cmp -s /tmp/filtered01.${F5} ${D2}/filtered01.${F5} || cp /tmp/filtered01.${F5} ${D2}/filtered01.${F5}
