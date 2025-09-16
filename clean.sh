#!/usr/bin/env bash

set -euo pipefail

dry_run=true
usr_dir="/home/enryu"
#colour the informative messages
info="\033[31m[INFO]\033[0m"
dry_msg="\033[33m[DRY]\033[0m "


help() {
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


clean() {
	[ -d $HOME/.cache/ ] && log du -sh $usr_dir/.cache/
	log rm -rf "$usr_dir/.cache/"*

	[ -d $HOME/.cargo/ ] && log du -sh $usr_dir/.cargo/
	log rm -rf "$usr_dir/.cargo/"*

	[ -d $HOME/.gradle/caches/ ] && log du -sh $usr_dir/.gradle/caches/
	log rm -rf "$usr_dir/.gradle/caches/"*

	[ -d $HOME/.local/share/gnome-builder/ ] && log du -sh $usr_dir/.local/share/gnome-builder/
	log rm -rf "$usr_dir/.local/share/gnome-builder/"*

	[ -d $HOME/.local/share/rustup/ ] && log du -sh $usr_dir/.local/share/rustup/
	log rm -rf "$usr_dir/.local/share/rustup/"*

	[ -d $HOME/.local/share/yarn/ ] && log du -sh $usr_dir/.local/share/yarn/
	log rm -rf "$usr_dir/.local/share/yarn/"*

	log journalctl --disk-usage #show how much storage logs take

	# mozilla stuff
	[ -d $HOME/.mozilla/firefox/*.default-release/storage/default/* ] && \
		log du -sh "$usr_dir/.mozilla/firefox/*.default-release/storage/default/"
	log rm -rf "$usr_dir/.mozilla/firefox/*.default-release/storage/default/*"
}


clean_logs() {
	log echo "type password to keep logs for 7 days max"
	log sudo journalctl --vacuum-time=7d #keep logs only for 7 days
	log journalctl --disk-usage #show how much storage logs take
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
		clean
		clean_logs
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
