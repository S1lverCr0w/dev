#!/usr/bin/env bash

#script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

datetime=`date +%y%m%d_%H%M%S`

# fonts #
paru -S --noconfirm ttf-nerd-fonts-symbols ttf-jetbrains-mono ttf-material-symbols-variable-git otf-font-awesome

# nvim #
paru -S nvim bash-language-server pyright

mv ~/.config/nvim ~/.config/nvim_$datetime
mv ~/.local/share/nvim ~/.local/share/nvim_$datetime
rm -rf ~/.cache/nvim

cp -r nvim/ ~/.config/nvim

# alacritty #
paru -S alacritty
mv ~/.config/alacritty ~/.config/alacritty_$datetime
cp -r alacritty/ ~/.config/alacritty/

# helix #
paru -S helix
mv ~/.config/helix ~/.config/helix$datetime
cp -r helix/ ~/.config/helix/

# python #
pacman -S pyside6-tools qt6-tools python-poetry

# nano #
mv ~/.config/nano/nanorc ~/.config/nano/nanorc_$datetime
cp nanorc ~/.config/nano/

# confing #
mv ~/.bashrc ~/.bashrc_%datetime
cp bashrc ~/.bashrc
mv ~/.bash_profile ~/.bash_profile_%datetime
cp bash_profile ~/.bash_profile
