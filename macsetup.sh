#!/usr/bin/env bash

set -euo pipefail

#script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
datetime=$(date +%y%m%d_%H%M%S)
dry_run=false


help() {
	echo "Usage: $(basename "$0") [OPTIONS] [COMPONENTS]"
	echo
	echo "Options:"
	echo "  --dry       Simulate actions without executing"
	echo "  --help      Show this help message"
	echo
	echo "Components:"
	echo "  font        Install and configure fonts"
	echo "  nvim        Set up Neovim config"
	echo "  dev         Set up editors and some cmd tools"
	echo "  alacritty   Set up Alacritty config"
	echo "  helix       Set up Helix editor"
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


# mac #
mac() {
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew install nvim firefox alacritty bash
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
	 log brew install neovim fzf npm ripgrep fd ed

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


# python ##
python() {
	log sudo pacman -S --noconfirm --needed pyside6-tools qt6-tools python-poetry
}


# nano ##
nano() {
	log sudo pacman -S --noconfirm --needed nano
	[ -d $HOME/.config/nano/nanorc ] &&  log mv $HOME/.config/nano/nanorc $HOME/.config/nano/nanorc_$datetime
	log mkdir -p "$HOME/.config/nano/"
	log cp "config/nanorc" "$HOME/.config/nano/"
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


# clean ##
clean() {
	echo "[INFO] Cleaning up backup directories created"
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
		case "$arg" in
			--dry) dry_run=true ;;
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
