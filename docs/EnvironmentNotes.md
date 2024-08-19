

### Integrating w/ VS Code
I use Git for Windows which installs a MINGW64 terminal that provides a bash command line interface. I personally keep my local repositories on local storage in location that is NOT backed by OneDrive or Dropbox. For me that is c:\REPOs. In this way I don't have to worry about the performance overhead of cloud storage and backup needs are met with frequent save and syncs in a DEV branch up to the remote repository on Github.
From a VS Code perspective I open first set up a local repository with this commands...
1. startup a MINGW64 window
2. cd /c/REPOs/MyProjects/chessStuff/M8_ChessEngine   # cd to directory where you want to locate you local repository
3. git clone https://github.com/bigmcdaddy8/PertyFish.git  # creates a local repository sync'ed to the HEAD of the master branch
4. cd PertyFish
5. git checkout DEV   # sync up to the HEAD of the DEV branch
6. In VS Code File->Open Folder c:\REPOs\MyProjects\chessStuff\M8_ChessEngine\PertyFish


