## Dot File Manager

quick script to set up my dev environment using bash

### usage
for help run
```
./setup.sh --help
```
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
to do a dry run on a specific funtion/functions pass it as an argument
```
./setup.sh nvim font config
```
to run the function/functions just add --run 
```
./setup.sh nvim font config --run
```


