

### Integrating w/ VS Code
I use Git for Windows which installs a MINGW64 terminal that provides a bash command line interface. I personally keep my local repositories on local storage in location that is NOT backed by OneDrive or Dropbox. For me that is c:\REPOs. In this way I don't have to worry about the performance overhead of cloud storage and backup needs are met with frequent save and syncs in a DEV branch up to the remote repository on Github.
From a VS Code perspective I open first set up a local repository with this commands...
1. startup a MINGW64 window
2. cd /c/REPOs/MyProjects/chessStuff/M8_ChessEngine   # cd to directory where you want to locate you local repository
3. git clone https://github.com/bigmcdaddy8/PertyFish.git  # creates a local repository sync'ed to the HEAD of the master branch
4. cd PertyFish
5. git checkout DEV   # sync up to the HEAD of the DEV branch
6. In VS Code File->Open Folder c:\REPOs\MyProjects\chessStuff\M8_ChessEngine\PertyFish


# Promoting DEV to Master
- turn DEBUGGING off in App.fx.yaml
- update docs - especially README
- update ProjectManagement.md with completed release Story
- commit, stage, sync
- login to github via browser
- - goto PertyFish repository
- - goto DEV branch
- - see something like "This branch is 547 commits ahead of, 2 commits behind master
- - click on the "547 commits ahead of" hyperlink
- - - click on "Create pull request" button
- - - - Title: Release Management v0.2.0 DEV to master
- - - - Description: 
    The current stable release of this project is release v0.2.0:
    - Supports  human vs. human play, human vs. computer, and computer vs. computer
    - Only allows legal moves including castling, en passant captures, and pawn promotions.
    - Has some built in diagnostics that can be used for testing
    - Supports 6 levels of computer difficulties
    - - fCE_100 (Random)
    - - fCE_200 (Bully)
    - - fCE_300 (Preschool)
    - - fCE_400 (Kindergarten)
    - - fCE_500 (1st Grade)
    - - fCE_600 (2nd Grade)
- - - - click on the "Create pull request" button
- - - pull request is now in the "Open" status state, scroll down and see "This branch has no conflicts with the base branch" and click on the "Merge pull request" button
- - - - Comment: accept pull request as submitted
- - - - click on the "Merge pull request" button
- - - - click on the "confirm merge" button
- - goto PertyFish repository main page
- - select master as the branch
- - On the middle right hand side click on the "Releases" header
- - - click on "Draft a new release" button
- - - update the description with the release description
- - - click on the create tag button and assign the tag to use when release is published (i.e., v0.2.0)
- - - click on the "Publish release" button

