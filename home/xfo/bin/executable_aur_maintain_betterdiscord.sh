#!/bin/bash

# Set variables
DISCORD_VERSION="$HOME/.config/BetterDiscord/au_discord_ver.txt"
NEW_DISCORD_VERSION="$HOME/.config/BetterDiscord/au_new_discord_ver.txt"
BDCTL_COMMAND="betterdiscordctl -i traditional install"

# Check and store the current output of `paru -Q discord`
paru -Q discord > "$NEW_DISCORD_VERSION"

# If the previous output file doesn't exist, create it
if [ ! -f "$DISCORD_VERSION" ]; then
    cp "$NEW_DISCORD_VERSION" "$DISCORD_VERSION"
fi

# Compare the output files
if ! cmp --silent "$DISCORD_VERSION" "$NEW_DISCORD_VERSION"; then
    # If there's a change, run the betterdiscordctl command and update the output file
    $BDCTL_COMMAND
    cp "$NEW_DISCORD_VERSION" "$DISCORD_VERSION"
fi

# Cleanup
rm "$NEW_DISCORD_VERSION"
