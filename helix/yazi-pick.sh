#!/bin/sh
# Open yazi in a throwaway Ghostty window and print ONE chosen path on stdout,
# for use as `:open %sh{...}` from Helix (see config.toml, C-y).
#
# Helix substitutes the whole expansion as a single argument and does not split
# it on whitespace, so paths containing spaces pass through fine -- but a
# multi-file selection cannot be emitted at once (it would open one buffer whose
# name is every path joined together). Instead yazi's picks are queued, and the
# C-y binding calls this script several times:
#
#   first  -- run yazi, queue the picks, print pick 1
#   next   -- print the next queued pick, or repeat the last one
#
# Repeating the last pick makes the surplus `:open` calls no-ops (re-opening a
# visible buffer just switches to it), so unused slots stay silent.
#
# Helix blocks while `first` runs, so the flag file is touched from an EXIT trap
# and the wait loop has a hard timeout -- closing the yazi window must never
# wedge the editor.

set -eu

mode=${1:-first}
queue="${TMPDIR:-/tmp}/helix-yazi-queue.$PPID"
last="$queue.last"

emit() { # remember what we printed so surplus calls can repeat it
	printf '%s' "$1" >"$last"
	printf '%s' "$1"
}

if [ "$mode" = first ]; then
	out=$(mktemp -t yazi-chooser)
	flag="$out.done"
	trap 'rm -f "$out" "$flag"' EXIT

	open -na Ghostty --args -e sh -c \
		"trap 'touch \"$flag\"' EXIT HUP INT TERM; yazi --chooser-file=\"$out\" \"$PWD\""

	# ~5 min ceiling at 0.1s per tick
	i=0
	while [ ! -e "$flag" ] && [ "$i" -lt 3000 ]; do
		sleep 0.1
		i=$((i + 1))
	done

	# Fresh queue every invocation; a cancelled yazi leaves it empty, which also
	# clears $last so surplus calls do not re-open a file from a previous run.
	sed -e '/^$/d' "$out" >"$queue" 2>/dev/null || : >"$queue"
	: >"$last"
fi

[ -s "$queue" ] || { cat "$last" 2>/dev/null || :; exit 0; }

pick=$(head -n 1 "$queue")
tail -n +2 "$queue" >"$queue.tmp" && mv "$queue.tmp" "$queue"
emit "$pick"
