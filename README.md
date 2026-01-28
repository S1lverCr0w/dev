## Dot File Manager

quick script to set up a dev environment written in `bash`

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
---
### sample output
<table>
<tr>
<th align="left">

`$ ./setup.sh nvim`</th>
</tr>
<tr>
<td>

```bash
[DRY]  sudo pacman -S --noconfirm --needed neovim tree-sitter-cli bash-language-server pyright fzf npm base-devel ripgrep fd ed vi gvim
[DRY]  sudo pacman -S --noconfirm --needed jdk-openjdk
[DRY]  paru -S --noconfirm --needed jdtls
[DRY]  mv /home/S1lverCr0w/.config/nvim /home/S1lverCr0w/.config/nvim_260128_123427
[DRY]  mv /home/S1lverCr0w/.local/share/nvim /home/S1lverCr0w/.local/share/nvim_260128_123427
[DRY]  rm -rf /home/S1lverCr0w/.cache/nvim
[DRY]  rm -rf /home/S1lverCr0w/.local/state/nvim
[DRY]  mkdir -p /home/S1lverCr0w/.config/nvim
[DRY]  cp -r config/nvim /home/S1lverCr0w/.config/
```
</td>
</tr>
</table>

<table>
<tr>
<th align="left">

`$ ./copytorepo.sh config --run`</th>
</tr>
<td>

```bash
[INFO] cp -r /home/S1lverCr0w/.bashrc config/bashrc
[INFO] cp -r /home/S1lverCr0w/.bash_profile config/bash_profile
[INFO] cp -r /home/S1lverCr0w/.zshrc config/zshrc
```
</td>
</tr>
</table>
