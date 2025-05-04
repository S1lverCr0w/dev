#!/usr/bin/env bash

set -euo pipefail

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
dry_run=false


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
		if [[ "$arg" == "--dry" ]]; then
			dry_run=true
		else
			args+=("$arg")
		fi
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
