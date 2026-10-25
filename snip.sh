#!/bin/bash

# Drag a region, put it on the clipboard as PNG, and flash a short toast once
# it is there. A cancelled pick ends quietly.
#
# Omarchy's `region copy` mode exits 0 whether a region was taken or the pick
# was cancelled, so it can't say when to notify. `save` prints the file path
# only after grim succeeds, so use that, aimed at a scratch directory instead
# of Pictures, and copy the file ourselves.

MESSAGE="Add image to clipboard"

dir="${XDG_RUNTIME_DIR:-/tmp}/snip"
# Pre-created: omarchy-capture-screenshot announces any directory it creates.
mkdir -p "$dir"

file=$(OMARCHY_SCREENSHOT_DIR="$dir" omarchy-capture-screenshot region save) || exit
[[ -n $file ]] || exit 0

# wl-copy buffers stdin before it forks, so the file can go right away.
wl-copy --type image/png <"$file" || exit
rm -f "$file"

# The notification service holds a toast for at least 5s whatever timeout is
# asked for, so take it down ourselves.
omarchy-notification-send "$MESSAGE" || exit 0
sleep 1.5
omarchy-shell notifications dismiss "$MESSAGE" >/dev/null
