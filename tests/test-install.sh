#!/bin/sh
set -eu
repo=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
mkdir -p "$repo/.test-output"
test_root=$(mktemp -d "$repo/.test-output/sh-XXXXXX")
destination="$test_root/space test/skills"
sh "$repo/install.sh" "$destination"
installed="$destination/learn-everything"
for name in SKILL.md README.md; do
    cmp "$repo/$name" "$installed/$name"
done
for name in agents assets references; do
    diff -r "$repo/$name" "$installed/$name"
done
test "$(find "$installed" -type f | wc -l | tr -d ' ')" = 10
printf '%s\n' 'preserve-existing' > "$installed/keep.txt"
if sh "$repo/install.sh" "$destination"; then
    printf '%s\n' 'Duplicate installation should fail' >&2
    exit 1
fi
test "$(cat "$installed/keep.txt")" = preserve-existing
mkdir "$test_root/incomplete"
cp "$repo/install.sh" "$test_root/incomplete/install.sh"
if sh "$test_root/incomplete/install.sh" "$test_root/rejected"; then
    printf '%s\n' 'Incomplete download should fail' >&2
    exit 1
fi
test ! -e "$test_root/rejected"
printf '%s\n' 'PASS: first install, content comparison, spaces, duplicate protection, incomplete download'
printf 'Isolated test artifacts: %s\n' "$test_root"
