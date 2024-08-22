

### testing/bin/createFilteredFiles.sh

This script is run manually, it will go through each file in the testing/data/EPD_files directory and pull out the FEN data and output the FEN data into a corresponding file in the testing/data/filteredFiles directory. This step is needed to prepare file for processing the testing/bin/generateEPD_D1_file.sh script.

### testing/bin/generateEPD_D1_file.sh

This script is run manually and is used to select a file from the testing/data/filteredFiles directory and input the FEN into stockfish to determine the number of legal moves moves at a depth 1 (i.e.,  "go perft 1"). It creates an output file that has e

### testing/data/EPD_files

This directory contains files downloaded from the internet. Most of them came from [Chris Whittington EPD Collection](https://github.com/ChrisWhittington/Chess-EPDs) .

Most of the files contain a FEN chess position along with some associated peft data. We take the FEN data and have written a sheel script that uses stockfish to get the number of nodes that is output from the "go perft 1" command. The results of which are placed in an output file along with the FEN, so that the positions can be used to valid the number of legal moves PertyFish thinks there are at a depth of 1 vs what stockfish thinks. 

### testing/data/filteredFiles

This directory contains files that output from the testing/bin/createFilteredFiles.sh script. 


