#!/usr/bin/env bash

source ./helpers.sh

set -euo pipefail

#script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
datetime=$(date +%y%m%d_%H%M%S)
dry_run=true
#colour the informative messages
info="\033[31m[INFO]\033[0m"
dry_msg="\033[33m[DRY]\033[0m "

## color palette # not used
ERROR="\033[91m[ERROR]\033[0m"     # bright red
SUCCESS="\033[92m[SUCCESS]\033[0m" # bright green
WARNING="\033[93m[WARNING]\033[0m" # bright yellow/orange
INFO="\033[96m[INFO]\033[0m"       # cyan (clean & visible)
DEBUG="\033[94m[DEBUG]\033[0m"     # blue
NOTICE="\033[95m[NOTICE]\033[0m"   # magenta
DRY="\033[33m[DRY]\033[0m"         # normal yellow (your original)
ORANGE="\033[38;5;208m[ORANGE]\033[0m"  # real orange
## color palette # not used

SU="doas" # privilege escalation program


# fonts #
font() {
	log paru -S --noconfirm --needed ttf-material-symbols-variable-git
	log $SU pacman -S --noconfirm --needed ttf-nerd-fonts-symbols ttf-jetbrains-mono \
		otf-font-awesome wqy-zenhei ibus-libpinyin noto-fonts-cjk
}


# misc #
misc() {
	log $SU pacman -S --noconfirm --needed dysk
	# # gnome
	# gsettings list-keys org.gnome.desktop.interface # show available options
	log gsettings set org.gnome.nautilus.preferences open-folder-on-dnd-hover false # disable nautilus open on hover
}


# nvim #
nvim() {
	log $SU pacman -S --noconfirm --needed neovim tree-sitter-cli shellcheck fzf base-devel ripgrep fd \
		 ed vi gvim
	log $SU pacman -S --noconfirm --needed clang zig zls lua-language-server stylua
	log $SU pacman -S --noconfirm --needed ty ruff
	# log $SU pacman -S --noconfirm --needed fennel fnlfmt
	   # # run archlinux-java status to see if jdk path is set
	   # # run archlinux-java fix to set path etc
	log $SU pacman -S --noconfirm --needed jdk-openjdk
	log paru -S --noconfirm --needed jdtls fortls asm-lsp

	nvim_backup
}


# nvim_backup #
nvim_backup() {
	[ -d $HOME/.config/nvim/ ] &&  log mv $HOME/.config/nvim $HOME/.config/nvim_$datetime
	# [ -d $HOME/.local/share/nvim/ ] &&  log mv $HOME/.local/share/nvim $HOME/.local/share/nvim_$datetime
	nvim_clear

	log mkdir -p "$HOME/.config/nvim"
	log cp -r "config/nvim" "$HOME/.config/"
}


# nvim_clear #
nvim_clear() {
	[ -d $HOME/.local/share/nvim/ ] &&  log mv $HOME/.local/share/nvim $HOME/.local/share/nvim_$datetime
	log rm -rf $HOME/.cache/nvim
	log rm -rf $HOME/.local/state/nvim
}


# vim #
vim() {
	log $SU pacman -S --noconfirm --needed gvim
	[ -d "$HOME/.vim" ] &&  log mv $HOME/.vim $HOME/.vim_$datetime
	log rm -rf $HOME/.vim
	log mkdir -p "$HOME/.vim"
	log cp -r "config/vim/*" "$HOME/.vim"
}


# dev #
dev() {
	 log $SU pacman -S --noconfirm --needed base-devel fzf sed grep ed vi neovim gvim nano
	 log $SU pacman -S --noconfirm --needed tldr man-db texinfo wikiman
	 log $SU pacman -S --noconfirm --needed zig zls gcc-fortran valgrind gdb shellcheck
	 log $SU pacman -S --noconfirm --needed dart-sass
	log paru -S --noconfirm --needed jdtls fortls asm-lsp
	 # not working ???
	 # log printf '%s\n' 0a "set debuginfod enabled on" . w | log $SU ed /etc/gdb/gdbinit
}


# alacritty #
alacritty() {
	log $SU pacman -S --noconfirm --needed alacritty
	[ -d $HOME/.config/alacritty/ ] &&  log mv $HOME/.config/alacritty $HOME/.config/alacritty_$datetime
	log mkdir -p "$HOME/.config/alacritty/"
	log cp -r "config/alacritty" "$HOME/.config/"
}


# helix #
helix() {
	log $SU pacman -S --noconfirm --needed helix
	[ -d $HOME/.config/helix/ ] &&  log mv $HOME/.config/helix $HOME/.config/helix_$datetime
	log mkdir -p "$HOME/.config/helix/"
	log cp -r "config/helix" "$HOME/.config/"
}


# zed #
zed() {
	 log $SU pacman -S --noconfirm --needed zed amdvlk

	[ -d $HOME/.config/zed/ ] &&  log mv $HOME/.config/zed $HOME/.config/zed_$datetime
	[ -d $HOME/.local/share/zed/ ] &&  log mv $HOME/.local/share/zed $HOME/.local/share/zed_$datetime
	log rm -rf $HOME/.cache/zed

	log mkdir -p "$HOME/.config/zed"
	log cp -r "config/zed" "$HOME/.config/"
}


# python #
python() {
	log $SU pacman -S --noconfirm --needed pyside6-tools qt6-tools python-poetry
}


# nano #
nano() {
	log $SU pacman -S --noconfirm --needed nano
	[ -d $HOME/.config/nano/nanorc ] &&  log mv $HOME/.config/nano/nanorc $HOME/.config/nano/nanorc_$datetime
	log mkdir -p "$HOME/.config/nano/"
	log cp "config/nanorc" "$HOME/.config/nano/"
}


# hypr #
hyprland() {
	log $SU pacman -S --noconfirm --needed hyprland dunst wl-clipboard rofi
	[ -d $HOME/.config/hypr/ ] &&  log mv $HOME/.config/hypr $HOME/.config/hypr_$datetime
	log mkdir -p "$HOME/.config/hypr/"
	log cp -r "config/hypr" "$HOME/.config/"
}


# fabric #
fabric() {
	log $SU pacman -S --noconfirm --needed python gtk3 cairo gtk-layer-shell libgirepository \
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
	log $SU pacman -S --noconfirm --needed waybar pavucontrol hyprlock
	log paru -S --noconfirm --needed wlogout
	[ -d $HOME/.config/waybar/ ] &&  log mv $HOME/.config/waybar $HOME/.config/waybar_$datetime
	log mkdir -p "$HOME/.config/waybar/"
	log cp -r "config/waybar" "$HOME/.config/"
}

# sql #
sql() {
	log $SU pacman -S --noconfirm --needed mysql-workbench mariadb
	log $SU mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
	log $SU systemctl start mariadb.service

	# $SU mariadb -u root -p
	## in mariadb
	# alter user 'root'@'localhost' identified by 'password'; # "password" is the actual apssword
	# flush privileges
	# \q
	# $SU mariadb -u root -p
	# use mysql
	# \q
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

	log find $HOME/ -maxdepth 1 -type d -regextype posix-extended \
		-regex ".*/.vim_[0-9]{6}_[0-9]{6}" -exec rm -rf {} +
	find $HOME/ -maxdepth 1 -type d -regextype posix-extended \
		-regex ".*/.vim_[0-9]{6}_[0-9]{6}" -printf "$info %p\n"

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
			--help) help_setup; exit 0 ;;
			*) args+=("$arg") ;;
		esac
	done

	if [[ ${#args[@]} -eq 0 ]]; then
		font
		misc
		nvim
		nvim_backup
		nvim_clear
		vim
		dev
		alacritty
		helix
		zed
		python
		nano
		# hyprland
		# waybar
		# fabric
		sql
		config
	else
		for component in "${args[@]}"; do
			if declare -f "$component" > /dev/null; then
				"$component"
			else
				echo "Unknown argument: $component"
				echo "Use --help to see valid options." exit 1
			fi
		done
	fi
}

main "$@"
