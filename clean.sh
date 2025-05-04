#!/usr/bin/env bash

set -euo pipefail

dry_run=false
usr_dir="/home/enryu"

clean() {
	log rm -rf "$usr_dir/.cargo/"*
	log rm -rf "$usr_dir/.cache/"*
	log rm -rf "$usr_dir/.gradle/caches/"*
	log rm -rf "$usr_dir/.local/share/gnome-builder/"*
	log rm -rf "$usr_dir/.local/share/rustup/"*
	log rm -rf "$usr_dir/.local/share/yarn/"*
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
		if [[ "$arg" == "--dry" ]]; then
			dry_run=true
		else
			args+=("$arg")
		fi
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
