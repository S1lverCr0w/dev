#!/usr/bin/env bash

set -euo pipefail

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
dry_run=false


help() {
	echo "Usage: $(basename "$0") [OPTIONS] [COMPONENTS]"
	echo
	echo "Options:"
	echo "  --dry         Simulate actions without executing"
	echo "  --help        Show this help message"
	echo
	echo "Components:"
	echo "  nvim          Copy Neovim config to repo"
	echo "  alacritty     Copy Alacritty config to repo"
	echo "  helix         Copy Helix config to repo"
	echo "  nano          Copy Nano config to repo"
	echo "  hyprland      Copy Hyprland config to repo"
	echo "  waybar        Copy Waybar config to repo"
	echo "  config        Copy .bashrc and .bash_profile to repo"
	echo
	echo "Examples:"
	echo "  $(basename "$0")              Copy all configs to repo"
	echo "  $(basename "$0") --dry nvim   Simulate copying of Neovim config to repo"
}


# nvim #
nvim() {
	log cp -r $HOME/.config/nvim/* nvim
}


# alacritty #
alacritty() {
	log cp -r $HOME/.config/alacritty/* alacritty
}


# helix #
helix() {
	log cp -r $HOME/.config/helix/* helix
}


# nano #
nano() {
	echo "$script_dir"
	log cp $HOME/.config/nano/* $script_dir
}


# hyprland #
hyprland() {
	log cp -r $HOME/.config/hypr/* hypr
}


# waybar #
waybar() {
	log cp -r $HOME/.config/waybar/* waybar
}


# configs #
config() {
	log cp -r $HOME/.bashrc bashrc
	log cp -r $HOME/.bash_profile bash_profile
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
		nvim
		alacritty
		helix
		nano
		hyprland
		waybar
		config
	else
		for argument in "${args[@]}"; do
			if declare -f "$argument" > /dev/null; then
				"$argument"
			else
				echo "Unknown argument: $argument"
				exit 1
			fi
		done
	fi
}

main "$@"
