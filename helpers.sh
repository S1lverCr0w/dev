#!/usr/bin/env bash

help_setup() {
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
	echo "  nvim_clear  Delete the installed plugins for a fresh start (can help with some plugins not working and other errors)"
	echo "  vim         Set up Vim config"
	echo "  dev         Set up editors and some cmd tools"
	echo "  alacritty   Set up Alacritty config"
	echo "  helix       Set up Helix editor"
	echo "  zed         Set up Zed editor"
	echo "  python      Install Python dev tools"
	echo "  nano        Configure Nano"
	echo "  hyprland    Set up Hyprland config OUTDATED"
	echo "  fabric      Set up Fabric config OUTDATED"
	echo "  waybar      Set up Waybar config OUTDATED"
	echo "  config      Copy .bashrc and .bash_profile"
	echo "  clean       Remove old backup configs"
	echo
	echo "Examples:"
	echo "  $(basename "$0")                Dry-run all setup steps"
	echo "  $(basename "$0") --run          Run all setup steps"
	echo "  $(basename "$0") nvim           Run the Neovim setup"
	echo "  $(basename "$0") --dry nvim     Dry-run Neovim setup"
}


help_copytorepo() {
	echo "Usage: $(basename "$0") [OPTIONS] [COMPONENTS]"
	echo
	echo "Options:"
	echo "  --run         Execute actions without simulating"
	echo "  --help        Show this help message"
	echo
	echo "Components:"
	echo "  nvim          Copy Neovim config to repo"
	echo "  vim           Copy vim config to repo"
	echo "  alacritty     Copy Alacritty config to repo"
	echo "  helix         Copy Helix config to repo"
	echo "  zed           Copy Zed config to repo"
	echo "  nano          Copy Nano config to repo"
	echo "  hyprland      Copy Hyprland config to repo"
	echo "  fabric        Copy Fabric config to repo"
	echo "  waybar        Copy Waybar config to repo"
	echo "  eww           Copy Eww config to repo"
	echo "  config        Copy .bashrc and .bash_profile to repo"
	echo
	echo "Examples:"
	echo "  $(basename "$0")              Simulate copying all configs to repo"
	echo "  $(basename "$0") --run        Copy all configs to repo"
	echo "  $(basename "$0") nvim         Simulate copying of Neovim config to repo"
	echo "  $(basename "$0") --run nvim   Copy Neovim config to repo"
}


help_clean() {
	echo "Usage: $(basename "$0") [OPTIONS] [COMPONENTS]"
	echo
	echo "Options:"
	echo "  --run         Execute actions"
	echo "  --help        Show this help message"
	echo
	echo "Components:"
	echo "  clean         Delete cache, cargo, rustup, yarn, etc."
	echo "  clean_logs    Keep only 7 days of journal logs"
	echo
	echo "Examples:"
	echo "  $(basename "$0")                 Dry-run full cleanup"
	echo "  $(basename "$0") clean           Dry-run only the clean function"
	echo "  $(basename "$0") clean           Simulate cleanup"
	echo "  $(basename "$0") --run clean     Run only the clean function"
}


help_macsetup() {
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
