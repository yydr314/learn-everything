#!/bin/sh
set -eu

source_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
skills_dir=${1:-"$HOME/.agents/skills"}
if [ "$#" -gt 1 ]; then
    printf '%s\n' 'Usage: sh install.sh [skills-parent-directory]' >&2
    exit 1
fi
for name in SKILL.md README.md agents assets references; do
    if [ ! -e "$source_dir/$name" ]; then
        printf 'Incomplete download: missing %s. Extract the entire repository first.\n' "$name" >&2
        exit 1
    fi
done
mkdir -p -- "$skills_dir"
skills_dir=$(CDPATH= cd -- "$skills_dir" && pwd)
target=$skills_dir/study-system
if [ -e "$target" ] || [ -L "$target" ]; then
    printf 'Already exists: %s. Back up and move the existing skill before installing again.\n' "$target" >&2
    exit 1
fi
# Reserve the destination atomically; do not overwrite another installation.
mkdir -- "$target"
trap 'printf "Installation interrupted. Inspect the incomplete folder: %s\n" "$target" >&2' 0
for name in SKILL.md README.md agents assets references; do
    cp -R -- "$source_dir/$name" "$target/"
done
trap - 0
printf 'Installed: %s\n' "$target"
printf '%s\n' 'Open a new Codex chat and use $study-system. Restart the app if needed.'
