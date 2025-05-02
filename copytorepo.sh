#!/usr/bin/env bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"


# nvim #
nvim() {
	cp -r $HOME/.config/nvim/* nvim
}


# alacritty #
alacritty() {
	cp -r $HOME/.config/alacritty/* alacritty
}


# helix #
helix() {
	cp -r $HOME/.config/helix/* helix
}


# nano #
nano() {
	echo "$script_dir"
	cp $HOME/.config/nano/* $script_dir
}


# hyprland #
hyprland() {
	cp -r $HOME/.config/hypr/* hypr
}


# waybar #
waybar() {
	cp -r $HOME/.config/waybar/* waybar
}


# configs #
configs() {
	cp -r $HOME/.bashrc bashrc
	cp -r $HOME/.bash_profile bash_profile
}


main() {
	nvim
	alacritty
	helix
	nano
	hyprland
	waybar
	configs
}


main
