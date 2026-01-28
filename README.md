## Dot File Manager

quick script to set up a dev environment using bash

### what can it do?
- copy all the dot files into their respective directories and back up the current dot files
- do a dry run by default and actually execute the commands only if `--run` flag is provided
- clean up all the backed up directories created once finished tinkering
- copy the all or specific dot directory to the repo so it can be backed up safely
- clean some Arch Linux specific cache

### usage
for help run
```
./setup.sh --help
```
---
to do a dry run on all the functions and display the commands to be ran in the terminal
```
./setup.sh
```
copy directory/directories to repo
```
./copytorepo.sh nvim --run
```
delete cache and other trivial files taking space
```
./clean.sh clean
```
---
to do a dry run on a specific funtion/functions pass it as an argument
```
./setup.sh nvim font config
```
to run the function/functions just add --run 
```
./setup.sh nvim font config --run
```


