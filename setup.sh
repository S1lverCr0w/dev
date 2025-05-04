#!/usr/bin/env bash

set -euo pipefail

#script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
datetime=$(date +%y%m%d_%H%M%S)
dry_run=false


# fonts #
font() {
	log paru -S --noconfirm --needed ttf-material-symbols-variable-git
	log sudo pacman -S --noconfirm --needed ttf-nerd-fonts-symbols ttf-jetbrains-mono \
		otf-font-awesome wqy-zenhei ibus-libpinyin noto-fonts-cjk
}


# nvim #
nvim() {
	 log sudo pacman -S --noconfirm --needed neovim bash-language-server pyright fzf npm base-devel

	[ -d $HOME/.config/nvim/ ] &&  log mv $HOME/.config/nvim $HOME/.config/nvim_$datetime
	[ -d $HOME/.local/share/nvim/ ] &&  log mv $HOME/.local/share/nvim $HOME/.local/share/nvim_$datetime
	log rm -rf $HOME/.cache/nvim

	log mkdir -p "$HOME/.config/nvim"
	log cp -r "nvim/" "$HOME/.config/"
}


# alacritty #
alacritty() {
	log sudo pacman -S --noconfirm --needed alacritty
	[ -d $HOME/.config/alacritty/ ] &&  log mv $HOME/.config/alacritty $HOME/.config/alacritty_$datetime
	log mkdir -p "$HOME/.config/alacritty/"
	log cp -r "alacritty/" "$HOME/.config/"
}


# helix #
helix() {
	log sudo pacman -S --noconfirm --needed helix
	[ -d $HOME/.config/helix/ ] &&  log mv $HOME/.config/helix $HOME/.config/helix_$datetime
	log mkdir -p "$HOME/.config/helix/"
	log cp -r "helix/" "$HOME/.config/"
}


# python #
python() {
	log sudo pacman -S --noconfirm --needed pyside6-tools qt6-tools python-poetry
}


# nano #
nano() {
	log sudo pacman -S --noconfirm --needed nano
	[ -d $HOME/.config/nano/nanorc ] &&  log mv $HOME/.config/nano/nanorc $HOME/.config/nano/nanorc_$datetime
	log mkdir -p "$HOME/.config/nano/"
	log cp "nanorc" "$HOME/.config/nano/"
}


# hypr #
hyprland() {
	log sudo pacman -S --noconfirm --needed hyprland dunst wl-clipboard rofi
	[ -d $HOME/.config/hypr/ ] &&  log mv $HOME/.config/hypr $HOME/.config/hypr_$datetime
	log mkdir -p "$HOME/.config/hypr/"
	log cp -r "hypr/" "$HOME/.config/"
}


# waybar #
waybar() {
	log sudo pacman -S --noconfirm --needed waybar
	[ -d $HOME/.config/waybar/ ] &&  log mv $HOME/.config/waybar $HOME/.config/waybar_$datetime
	log mkdir -p "$HOME/.config/waybar/"
	log cp -r "waybar/" "$HOME/.config/"
}


# confings #
config() {
	[ -f $HOME/.bashrc ] &&  log mv $HOME/.bashrc $HOME/.bashrc_$datetime
	log cp "bashrc" "$HOME/.bashrc"
	[ -f $HOME/.bash_profile ] &&  log mv $HOME/.bash_profile $HOME/.bash_profile_$datetime
	log cp "bash_profile" "$HOME/.bash_profile"
	echo "[INFO] source .bashrc or reopen the terminal"
}


clean() {
	echo "[INFO] Cleaning up backup directories creatd"
	log find "$HOME/.config" -maxdepth 1 -type d -regextype posix-extended \
		-regex ".*/[^/]+_[0-9]{6}_[0-9]{6}" -exec rm -rfv {} +
	log find $HOME/.local/share -maxdepth 1 -type d -regextype posix-extended \
		-regex ".*/nvim_[0-9]{6}_[0-9]{6}" -exec rm -rf {} +
	log find $HOME -maxdepth 1 -type f -regextype posix-extended \
		-regex ".*/\.bashrc_[0-9]{6}_[0-9]{6}" -exec rm -v {} +
	log find $HOME -maxdepth 1 -type f -regextype posix-extended \
		-regex ".*/\.bash_profile_[0-9]{6}_[0-9]{6}" -exec rm -v {} +
}


log() {
	if [[ "$dry_run" == true ]]; then
		echo "[DRY] $*"
	else
		echo "[INFO] $*"
		eval "$@"
	fi
}


main() {
	args=()
	for arg in "$@"; do
		if [[ "$arg" == "--dry" ]]; then
			dry_run=true
		else
			args+=("$arg")
		fi
	done

	if [[ ${#args[@]} -eq 0 ]]; then
		font
		nvim
		alacritty
		helix
		python
		nano
		hyprland
		waybar
		config
	else
		for component in "${args[@]}"; do
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
