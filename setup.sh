#!/usr/bin/env bash

set -euo pipefail

#script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
datetime=$(date +%y%m%d_%H%M%S)
dry_run=true
#colour the informative messages
info="\033[31m[INFO]\033[0m"
dry_msg="\033[33m[DRY]\033[0m "


help() {
	echo "Usage: $(basename "$0") [OPTIONS] [COMPONENTS]"
	echo
	echo "Options:"
	# echo "  --dry       Simulate actions without executing"
	echo "  --run       Execute actions without simulating"
	echo "  --help      Show this help message"
	echo
	echo "Components:"
	echo "  font        Install and configure fonts"
	echo "  nvim        Set up Neovim config"
	echo "  dev         Set up editors and some cmd tools"
	echo "  alacritty   Set up Alacritty config"
	echo "  helix       Set up Helix editor"
	echo "  zed         Set up Zed editor"
	echo "  python      Install Python dev tools"
	echo "  nano        Configure Nano"
	echo "  hyprland    Set up Hyprland config"
	echo "  fabric      Set up Fabric config"
	echo "  waybar      Set up Waybar config"
	echo "  config      Copy .bashrc and .bash_profile"
	echo "  clean       Remove old backup configs"
	echo
	echo "Examples:"
	echo "  $(basename "$0")                Run all setup steps"
	echo "  $(basename "$0") --dry nvim     Dry-run Neovim setup"
}


# fonts #
font() {
	log paru -S --noconfirm --needed ttf-material-symbols-variable-git
	log sudo pacman -S --noconfirm --needed ttf-nerd-fonts-symbols ttf-jetbrains-mono \
		otf-font-awesome wqy-zenhei ibus-libpinyin noto-fonts-cjk
}


# nvim #
nvim() {
	 log sudo pacman -S --noconfirm --needed neovim bash-language-server pyright fzf npm base-devel ripgrep fd \
		 ed vi gvim

	[ -d $HOME/.config/nvim/ ] &&  log mv $HOME/.config/nvim $HOME/.config/nvim_$datetime
	[ -d $HOME/.local/share/nvim/ ] &&  log mv $HOME/.local/share/nvim $HOME/.local/share/nvim_$datetime
	log rm -rf $HOME/.cache/nvim

	log mkdir -p "$HOME/.config/nvim"
	log cp -r "config/nvim" "$HOME/.config/"
}


# dev #
dev() {
	 log sudo pacman -S --noconfirm --needed base-devel fzf sed grep tldr man-db texinfo wikiman ed vi neovim gvim nano zig
}


# alacritty #
alacritty() {
	log sudo pacman -S --noconfirm --needed alacritty
	[ -d $HOME/.config/alacritty/ ] &&  log mv $HOME/.config/alacritty $HOME/.config/alacritty_$datetime
	log mkdir -p "$HOME/.config/alacritty/"
	log cp -r "config/alacritty" "$HOME/.config/"
}


# helix #
helix() {
	log sudo pacman -S --noconfirm --needed helix
	[ -d $HOME/.config/helix/ ] &&  log mv $HOME/.config/helix $HOME/.config/helix_$datetime
	log mkdir -p "$HOME/.config/helix/"
	log cp -r "config/helix" "$HOME/.config/"
}


# zed #
zed() {
	 log sudo pacman -S --noconfirm --needed zed amdvlk

	[ -d $HOME/.config/zed/ ] &&  log mv $HOME/.config/zed $HOME/.config/zed_$datetime
	[ -d $HOME/.local/share/zed/ ] &&  log mv $HOME/.local/share/zed $HOME/.local/share/zed_$datetime
	log rm -rf $HOME/.cache/zed

	log mkdir -p "$HOME/.config/zed"
	log cp -r "config/zed" "$HOME/.config/"
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
	log cp "config/nanorc" "$HOME/.config/nano/"
}


# hypr #
hyprland() {
	log sudo pacman -S --noconfirm --needed hyprland dunst wl-clipboard rofi
	[ -d $HOME/.config/hypr/ ] &&  log mv $HOME/.config/hypr $HOME/.config/hypr_$datetime
	log mkdir -p "$HOME/.config/hypr/"
	log cp -r "config/hypr" "$HOME/.config/"
}


# fabric #
fabric() {
	log sudo pacman -S --noconfirm --needed python gtk3 cairo gtk-layer-shell libgirepository \
		gobject-introspection gobject-introspection-runtime python python-pip python-gobject \
		python-cairo python-loguru pkgconf
	[ -d $HOME/.config/fabric/ ] &&  log mv $HOME/.config/fabric $HOME/.config/fabric_$datetime
	# log mkdir -p "$HOME/main/software/fabric"
	# log cd "$HOME/main/software/fabric"
	# log python -m venv venv
	# log source venv/bin/activate
	# log pip install git+https://github.com/Fabric-Development/fabric.git
	# log pip install psutil
	log cp -r "config/fabric" "$HOME/.config/"
}


# waybar #
waybar() {
	log sudo pacman -S --noconfirm --needed waybar pavucontrol hyprlock
	log paru -S --noconfirm --needed wlogout
	[ -d $HOME/.config/waybar/ ] &&  log mv $HOME/.config/waybar $HOME/.config/waybar_$datetime
	log mkdir -p "$HOME/.config/waybar/"
	log cp -r "config/waybar" "$HOME/.config/"
}


# confings #
config() {
	[ -f $HOME/.bashrc ] &&  log mv $HOME/.bashrc $HOME/.bashrc_$datetime
	log cp "config/bashrc" "$HOME/.bashrc"
	[ -f $HOME/.bash_profile ] &&  log mv $HOME/.bash_profile $HOME/.bash_profile_$datetime
	log cp "config/bash_profile" "$HOME/.bash_profile"
	printf "$info source .bashrc or reopen the terminal\n"
}


clean() {
	# testing echo -e for mac/bsd compatibilty
	echo -e "$info Cleaning up backup directories created"
	printf "$info These will be permanently deleted\n"
	log find "$HOME/.config" -maxdepth 1 -type d -regextype posix-extended \
		-regex ".*/[^/]+_[0-9]{6}_[0-9]{6}" -exec rm -rfv {} +
	find "$HOME/.config" -maxdepth 1 -type d -regextype posix-extended \
		-regex ".*/[^/]+_[0-9]{6}_[0-9]{6}" -printf "$info %p\n"
	log find $HOME/.local/share -maxdepth 1 -type d -regextype posix-extended \
		-regex ".*/nvim_[0-9]{6}_[0-9]{6}" -exec rm -rf {} +
	find $HOME/.local/share -maxdepth 1 -type d -regextype posix-extended \
		-regex ".*/nvim_[0-9]{6}_[0-9]{6}" -printf "$info %p\n"
	log find $HOME -maxdepth 1 -type f -regextype posix-extended \
		-regex ".*/\.bashrc_[0-9]{6}_[0-9]{6}" -exec rm -v {} +
	find $HOME -maxdepth 1 -type f -regextype posix-extended \
		-regex ".*/\.bashrc_[0-9]{6}_[0-9]{6}" -printf "$info %p\n"
	log find $HOME -maxdepth 1 -type f -regextype posix-extended \
		-regex ".*/\.bash_profile_[0-9]{6}_[0-9]{6}" -exec rm -v {} +
	find $HOME -maxdepth 1 -type f -regextype posix-extended \
		-regex ".*/\.bash_profile_[0-9]{6}_[0-9]{6}" -printf "$info %p\n"
}


log() {
	if [[ "$dry_run" == true ]]; then
		printf "$dry_msg $*\n"
	else
		printf "$info $*\n"
		eval "$@"
	fi
}


main() {
	args=()
	for arg in "$@"; do
		case "$arg" in
			--run) dry_run=false ;;
			--help) help; exit 0 ;;
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
		hyprland
		waybar
		fabric
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
