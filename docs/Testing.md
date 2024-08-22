



### testing/data/EPD_files

This directory contains files downloaded from the internet. Most of them came from [Chris Whittington EPD Collection](https://github.com/ChrisWhittington/Chess-EPDs) .

Most of the files contain a FEN chess position along with some associated peft data. We take the FEN data and have written a sheel script that uses stockfish to get the number of nodes that is output from the "go perft 1" command. The results of which are placed in an output file along with the FEN, so that the positions can be used to valid the number of legal moves PertyFish thinks there are at a depth of 1 vs what stockfish thinks. 


