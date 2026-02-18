#!/usr/bin/env bash

source ./helpers.sh

set -euo pipefail

#script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
datetime=$(date +%y%m%d_%H%M%S)
dry_run=true
info="\033[31m[INFO]\033[0m"
dry_msg="\033[33m[DRY]\033[0m "


# mac #
mac() {
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew install nvim firefox alacritty bash coreutils
	brew install dash ## mac app  zeal ## windows/linux app ## offline programming documentation gui app
	# xattr -dr com.apple.quarantine "/Applications/Alacritty.app"
}


# fonts ##
font() {
	log brew install font-jebrains-mono 
	ttf-material-symbols-variable-git
	log sudo pacman -S --noconfirm --needed ttf-nerd-fonts-symbols ttf-jetbrains-mono \
		otf-font-awesome wqy-zenhei ibus-libpinyin noto-fonts-cjk
}


# nvim #
nvim() {
	 # log brew install neovim fzf npm ripgrep fd ed

	[ -d $HOME/.config/nvim/ ] &&  log mv $HOME/.config/nvim $HOME/.config/nvim_$datetime
	[ -d $HOME/.local/share/nvim/ ] &&  log mv $HOME/.local/share/nvim $HOME/.local/share/nvim_$datetime
	log rm -rf $HOME/.cache/nvim

	log mkdir -p "$HOME/.config/nvim"
	log cp -r "config/nvim" "$HOME/.config/"
}


# dev #
dev() {
	 # log sudo pacman -S --noconfirm --needed base-devel fzf sed grep tldr man-db wikiman ed vi neovim gvim nano zig
	 log brew install fzf tldr man-db ed neovim zig
}


# alacritty #
alacritty() {
	log brew install alacritty
	[ -d $HOME/.config/alacritty/ ] &&  log mv $HOME/.config/alacritty $HOME/.config/alacritty_$datetime
	log mkdir -p "$HOME/.config/alacritty/"
	log gcp -r "config/alacritty/" "$HOME/.config/"
}


# helix #
helix() {
	log brew install helix
	[ -d $HOME/.config/helix/ ] &&  log mv $HOME/.config/helix $HOME/.config/helix_$datetime
	log mkdir -p "$HOME/.config/helix/"
	log cp -r "config/helix" "$HOME/.config/"
}


# zed #
zed() {
	 log brew brew install zed

	[ -d $HOME/.config/zed/ ] &&  log mv $HOME/.config/zed $HOME/.config/zed_$datetime
	[ -d $HOME/.local/share/zed/ ] &&  log mv $HOME/.local/share/zed $HOME/.local/share/zed_$datetime
	log rm -rf $HOME/.cache/zed

	log mkdir -p "$HOME/.config/zed"
	log cp -r "config/zed" "$HOME/.config/"
}


# python #
python() {
	log brew install python
	# pyside6-tools qt6-tools python-poetry
}


# confings #
config() {
	[ -f $HOME/.bashrc ] &&  log mv $HOME/.bashrc $HOME/.bashrc_$datetime
	log cp "config/bashrc" "$HOME/.bashrc"
	[ -f $HOME/.bash_profile ] &&  log mv $HOME/.bash_profile $HOME/.bash_profile_$datetime
	log cp "config/bash_profile" "$HOME/.bash_profile"
	echo "[INFO] source .bashrc or reopen the terminal"
	log brew install coreutils
}


# clean #
clean() {
	echo "[INFO] Cleaning up backup directories created"
	log find "$HOME/.config" -maxdepth 1 -type d \
		-name "*_[0-9][0-9][0-9][0-9][0-9][0-9]_[0-9][0-9][0-9][0-9][0-9][0-9]" -exec rm -rfv {} +
	find "$HOME/.config" -maxdepth 1 -type d \
		-name "*_[0-9][0-9][0-9][0-9][0-9][0-9]_[0-9][0-9][0-9][0-9][0-9][0-9]" -exec printf "$info %s\n" {} \;
	log find "$HOME/.local/share" -maxdepth 1 -type d \
		-name "*nvim_[0-9][0-9][0-9][0-9][0-9][0-9]_[0-9][0-9][0-9][0-9][0-9][0-9]" -exec rm -rfv {} +
	find "$HOME/.local/share" -maxdepth 1 -type d \
		-name "*nvim_[0-9][0-9][0-9][0-9][0-9][0-9]_[0-9][0-9][0-9][0-9][0-9][0-9]" -exec printf "$info %s\n" {} \;


	log find $HOME -maxdepth 1 -type f \
		-name ".bashrc_[0-9][0-9][0-9][0-9][0-9][0-9]_[0-9][0-9][0-9][0-9][0-9][0-9]" -exec rm -rfv {} +
	find "$HOME" -maxdepth 1 -type f \
		-name ".bashrc_[0-9][0-9][0-9][0-9][0-9][0-9]_[0-9][0-9][0-9][0-9][0-9][0-9]" -exec printf "$info %s\n" {} \;
	log find $HOME -maxdepth 1 -type f \
		-name ".bash_profile_[0-9][0-9][0-9][0-9][0-9][0-9]_[0-9][0-9][0-9][0-9][0-9][0-9]" -exec rm -rfv {} +
	find "$HOME" -maxdepth 1 -type f \
		-name ".bash_profile_[0-9][0-9][0-9][0-9][0-9][0-9]_[0-9][0-9][0-9][0-9][0-9][0-9]" -exec printf "$info %s\n" {} \;
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
		case "$arg" in
			--run) dry_run=false ;;
			--help) help_macsetup; exit 0 ;;
			*) args+=("$arg") ;;
		esac
	done

	if [[ ${#args[@]} -eq 0 ]]; then
		font
		nvim
		dev
		alacritty
		helix
		zed
		python
		nano
		config
	else
		for component in "${args[@]}"; do
			if declare -f "$component" > /dev/null; then
				"$component"
			else
				echo "Unknown argument: $component"
				echo "Use --help to see valid options."
				exit 1
			fi
		done
	fi
}

main "$@"
