#!/usr/bin/env bash

usr_dir="/home/enryu"

rm -rf "$usr_dir/.cargo/"*

rm -rf "$usr_dir/.cache/"*

rm -rf "$usr_dir/.gradle/caches/"*

rm -rf "$usr_dir/.local/share/gnome-builder/"*

rm -rf "$usr_dir/.local/share/rustup/"*

rm -rf "$usr_dir/.local/share/yarn/"*

rm -rf "$usr_dir/.local/share/yarn/"*

journalctl --disk-usage #show how much storage logs take
#echo "type password to keep logs for 7 days max"
#doas journalctl --vacuum-time=7d #keep logs only for 7 days
