#!/bin/bash

paru -S nvim bash-language-server pyright

mv ~/.config/nvim ~/.config/nvim_`date +%y%m%d_%H%M%S`
mv ~/.local/share/nvim ~/.local/share/nvim_`date +%y%m%d_%H%M%S`
rm -rf ~/.cache/nvim

cp -r nvim/ ~/.config/nvim
