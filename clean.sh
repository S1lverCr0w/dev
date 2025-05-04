#!/usr/bin/env bash

set -euo pipefail

dry_run=false
usr_dir="/home/enryu"


help() {
	echo "Usage: $(basename "$0") [OPTIONS] [COMMANDS]"
	echo
	echo "Options:"
	echo "  --dry         Simulate actions without executing"
	echo "  --help        Show this help message"
	echo
	echo "Commands:"
	echo "  clean         Delete cache, cargo, rustup, yarn, etc."
	echo "  clean_logs    Keep only 7 days of journal logs"
	echo
	echo "Examples:"
	echo "  $(basename "$0")             Run full cleanup"
	echo "  $(basename "$0") clean       Run only the clean function"
	echo "  $(basename "$0") --dry clean Simulate cleanup"
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
}


clean_logs() {
	log echo "type password to keep logs for 7 days max"
	log sudo journalctl --vacuum-time=7d #keep logs only for 7 days
	log journalctl --disk-usage #show how much storage logs take
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
