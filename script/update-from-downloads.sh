#!/bin/sh

ROOTDIR=$(git rev-parse --show-toplevel)

# Ensure that there are no numbered versions after the first in downloads, because this would
# mean that parkernilson.json is not the newest one

DOWNLOADS_DIR="$HOME/Downloads"
PATTERN="parkernilson-*.json"

# Check if Downloads directory exists
if [[ ! -d "$DOWNLOADS_DIR" ]]; then
    echo "Error: Downloads directory not found at $DOWNLOADS_DIR" >&2
    exit 1
fi

# Search for matching files
matching_files=("$DOWNLOADS_DIR"/$PATTERN)

# Check if any files match the pattern
# The glob expansion will include the literal pattern if no matches are found
if [[ -e "${matching_files[1]}" ]]; then
    echo "Error: Found multile versions of parkernilson.json in Downloads:" >&2
    
    # List the matching files
    for file in "${matching_files[@]}"; do
        if [[ -e "$file" ]]; then
            echo "  - $(basename "$file")" >&2
        fi
    done
    
    exit 1
else
    echo "✓ Found only one version of parkernilson.json in Downloads."
fi

echo "Replacing ~/keyboards/splitkb/kyria/keymaps/parkernilson/keymap.json with the new version at ~/Downloads/parkernilson.json"
rm $ROOTDIR/keyboards/splitkb/kyria/keymaps/parkernilson/keymap.json
mv ~/Downloads/parkernilson.json $ROOTDIR/keyboards/splitkb/kyria/keymaps/parkernilson/keymap.json