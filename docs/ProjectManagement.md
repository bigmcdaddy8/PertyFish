

## Project Goals
I started PertyFish because I wanted to learn how to create a canvas app and I usually find most tutorials that are business related boring and difficult for me to follow. I have the bad characteristic of learning the best if I find something interesting, and my method of learning is to follow bright shiny objects of new nuggets of interest that I believe might be helpful on my overall quest.  So in my attempt to learn how to create a canvas app I created a Chess application written entirely in PowerFx. It is intended that the chess program will contain a chess engine that a human can play against, this embedded chess engine would also be written entirely in PowerFx.
### Realizations
While creating this chess program, it became apparent to me that the embedded chess engine would be facing some limitations because creating a chess engine using Low Code is definitely a case of using the wrong tool for the job. My goal was not to produce a chess engine that could necessarily play at a high level, playing at a very low level would be fine.. Starting off with a chess program that contains a chess engine that simply makes random moves is the first step. The goal was that the program would play "correctly", only legal moves and only allow the player to play legal moves.
Creating a chess program that only allows legal moves and supports all of the tricky aspects of chess is a great start, in the long run if the interest was there I could always work getting the program to play at a higher level.
### Chess Tricky Parts
- Castling
- En Passant 
- Pawn promotions 

## Upcoming work
Using Agile development methodology terms (in a very rough and causal manner) here is what needs to be done on this project...

### Epic - Create a Chess Program as a Power Apps Canvas App using only PowerFx

#### Feature 0001 - Make the project publicly available 
Use Github to make the project and source code publicly available. The files and support documentation should mostly follow some best practice standards in this regard. As all of this is new to the project owner (PowerFx, Github, OSS) and this is the very first attempt at all the technical topics, strict adherence to any standard is not a requirement at this time because I do not want to commit to a direction that I don't understand, but would rather grow in a direction that makes sense to me and the project. Usually I find creating documentation boring (would rather write code), but the idea of a properly organized project and standard documentation does sounds intriguing and worthwhile.

##### Story 0001-02 - Learn how to play well with others
I have no idea if anybody in the universe has any interest in a project like this. And if they did I have no idea how to properly run an OSS project, so I and this project probably won't draw much is any interest, that's OK, I am doing this because I currently find the subjects (OSS Project Management and a Chess Program that is a Low Code Canvas App) involved in this project interesting. I also have no idea how to market such a project, and like I said I am not sure I a ready to receive help because I have to idea on how to incorporate code changes from others.

##### Story 0001-03 - Project Marketing
Let the world know that this project exists, in case there is some interest.

##### Story 0001-04 - Minor doc improvements
The category that typo fixes and other minor updates are logged under. 

##### Story 0001-05 - Project Management Work
Additions/Updates to the ProjectManagement documentation.

##### Story 0001-06 - Release Management
- promote DEV to Master
- create a new release

#### Feature 0002 - Create diagnostic testing capability
In a private version I have built in regression testing, I may pull that forward or at least a simplified version of it. I ran into a problem where the sheer size (number of components) in that private version caused the program to basically become too large for the browser based Power Apps development tool to reliably load and save in a timely manner.

##### Story 0002-01 Create UDF diagnostic testing 
- create diagnostic screen
- create UDF testing capability

#### Feature 0003 - Create smarter embedded chess engines
Create smarter chess engines that are written using PowerFx




##### Story 0003-19 Developing CE_PF_800 (4th Grade)
- do not back away when challenged
- - determine if protected and if exchange is positive (or even)
- - determine situations when to step into a potential PAWN exchange situation
- - determine situation when to initiate a PAWN exchange
- Look for simple tactics
- - look for skewers 4q3/B1pkb3/4p3/3p1p2/pnpN1P2/8/r7/3K2QB b - - 1 63 # Ra1+!
- - be aware of their pinned pieces (may create board where pinned pieces are removed ?)
- Simple board strength analysis
- - number of attacked squares
- - number of protected squares
- - number of weak squares

#### Feature 0004 - Application Improvements

##### Story 0004-01 Miscellaneous minor bug fix
Fix a minor bug or issue.
- Ready for user input needs to be set to false when start button is clicked

##### Story 0004-02 Allow backup buttons for a user to undo a move
Add a undo button for a human player to undo a move.

##### Story 0004-02 Wrap log statements in a DEBUG check
Improve performance by putting log statements in an appropriate DEBUG check and then reduce logging levels

##### Story 0004-03 GAME_NODES Performance Improvements
- use localVars to reduce number of FEN/board conversions
- Reduce number of UpdateIf() calls
- Use localVars w/ Patch() 
- Remove unused/redundant fields to reduce update footprint

##### Story 0004-04 Ongoing minor enhancements
- use localVars to reduce number of FEN/board conversions
- change UDF_isPathClear() to UDF_isPathClearOnBoard
- Reduce number of UpdateIf() calls
- Use localVars w/ Patch() 
- Remove unused/redundant fields to reduce update footprint


#### Feature 0005 - Technical Documentation
Document the details of this project used PowerFx to create a chess program. Items such as the collection formats, and how they are used. The board layout, use of FEN, the legal move table, etc.

##### Story 0005-01 - Create Outline
Create Outline of what and where technical documentation should be housed and what it should contain.


#### Feature 0006 - User Documentation
Document how a user plays chess within the PertyFish canvas app

## Short-Term ToDo List



## Open Bugs




## Completed Work
##### Story 0003-09 Developing CE_PF_700 (3rd Grade)
- do not back away when challenged
- - determine if protected and if exchange is positive (or even)
- - determine situations when to step into a potential PAWN exchange situation
- Look for simple tactics
- - look for hung pieces

##### Story 0001-06 - Release Management v0.2.1

##### Story 0001-06 - Release Management v0.2.0 

##### Story 0003-08 Developing CE_PF_600 (2nd Grade)
- Look for simple tactics
- - look for forks

##### Story 0003-07 Developing CE_PF_500 (1st Grade)
- End game 
- - avoid stalemate
- - know when safe to enter adj king squares
- Add a heuristic that is logically opposite of heuristic11
- - is the target square attacked and unprotected
- - is the target square attacked and protected, but the exchange is unfavorable

##### Story 0003-06 400 Developing CE_PF_400 (Kindergarten)
- Do simple exchange calculation before capturing

##### Story 0003-05 Developing CE_PF_300 (Preschool)
- Simple END GAME strategies
- - push pawns forward
- - look to increase number of squares attacked adjacent and on opponent king in order to increase change of checkmate
- Simple awareness of game phase to aid in move selection

##### Story 0003-04 Chess Engine Development 200 (Bully)
- Elevate evaluation of capturing moves.
- Change in basic material value  preMove vs. postMove

##### Story 0003-07 Create ability to test computer vs. computer
- maintain win-loss-draw
- be able to specify how many times to play

##### Story 0004-02 Allow player to select promoteTo piece
Add a control to allow player pre-select the piece type the next pawn promotion move should promote to.

##### Story 0003-03 Add standardized Game Phase detection
Create a standard library method for determining which phase of the game a FEN is in.

##### Story 0003-03 Add initial draw detection
Program needs to be able to detect several standard DRAW situations
- 3 move repetitions (DONE)
- insufficient material (DONE)

##### Story 0003-02 Separate Player Choice
In preparation for chess engine vs chess engine play in the future, add ability for each player to specify whether they are human or computer, and then add to controls the ability for each player to specify which computer engine they will use (if they are a computer player).

##### Story 0002-01 perft D1 data
Create infrastructure needed to build perft D1 files that be used for manually testing PertyFish

##### Story 0001-01 - README
Create the outline for a respectable README, and then create stories for the work needed to create the major sections.

##### Story 0003-01 Separate Engine logic into separate components
To prevent the development of more complex chess engine logic from breaking previous table iterations, separate out the logic of the chess engines from each other and have a radio control where the use can select which engine they want to play against, selections something like...
- PertyFish Random (~100 ELO)
- PertyFish Beginner (~??? ELO)
- etc.
