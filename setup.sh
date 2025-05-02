#!/usr/bin/env bash


set -euo pipefail

#script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
datetime=$(date +%y%m%d_%H%M%S)


# fonts #
fonts() {
	paru -S --noconfirm ttf-nerd-fonts-symbols ttf-jetbrains-mono ttf-material-symbols-variable-git otf-font-awesome
}


# nvim #
nvim() {
	paru -S nvim --noconfirm bash-language-server pyright

	[ -d $HOME/.config/nvim/ ] && mv $HOME/.config/nvim $HOME/.config/nvim_$datetime
	[ -d $HOME/.local/share/nvim/ ] && mv $HOME/.local/share/nvim $HOME/.local/share/nvim_$datetime
	rm -rf $HOME/.cache/nvim

	mkdir -p "$HOME/.config/nvim"
	cp -r "nvim/" "$HOME/.config/"
}


# alacritty #
alacritty() {
	paru -S --noconfirm alacritty
	[ -d $HOME/.config/alacritty/ ] && mv $HOME/.config/alacritty $HOME/.config/alacritty_$datetime
	mkdir -p "$HOME/.config/alacritty/"
	cp -r "alacritty/" "$HOME/.config/"
}


# helix #
helix() {
	paru -S --noconfirm helix
	[ -d $HOME/.config/helix/ ] && mv $HOME/.config/helix $HOME/.config/helix$datetime
	mkdir -p "$HOME/.config/helix/"
	cp -r "helix/" "$HOME/.config/"
}


# python #
python() {
	pacman -S --noconfirm pyside6-tools qt6-tools python-poetry
}


# nano #
nano() {
	[ -d $HOME/.config/nano/nanorc ] && mv $HOME/.config/nano/nanorc $HOME/.config/nano/nanorc_$datetime
	mkdir -p "$HOME/.config/nano/"
	cp "nanorc" "$HOME/.config/nano/"
}


# hypr #
hyprland() {
	[ -d $HOME/.config/hypr/] && mv $HOME/.config/hypr $HOME/.config/hypr_$datetime
	mkdir -p "$HOME/.config/hypr/"
	cp -r "hypr/" "$HOME/.config/"
}


# waybar #
waybar() {
	[ -d $HOME/.config/waybar/] && mv $HOME/.config/waybar $HOME/.config/waybar_$datetime
	mkdir -p "$HOME/.config/waybar/"
	cp -r "waybar/" "$HOME/.config/"
}


# confings #
configs() {
	[ -f $HOME/.bashrc ] && mv $HOME/.bashrc $HOME/.bashrc_$datetime
	cp "bashrc" "$HOME/.bashrc"
	[ -f $HOME/.bash_profile ] && mv $HOME/.bash_profile $HOME/.bash_profile_$datetime
	cp "bash_profile" "$HOME/.bash_profile"

	journalctl --disk-usage #show how much storage logs take
	doas journalctl --vacuum-time=7d #keep logs only for 7 days
}


main() {
	if [[ $# -eq 0 ]]; then
		fonts
		nvim
		alacritty
		helix
		python
		nano
		hyprland
		waybar
		configs
	else
		for component in "$@"; do
			if declare -f "$component" > /dev/null; then
				"$component"
			else
				echo "Unknown argument: $component"
				exit 1
			fi
		done
	fi
}


main "$@"
