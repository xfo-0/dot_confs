#!/bin/bash

workspace_name="wsp"

# Get the current focused window ID
focused_id=$(swaymsg -t get_tree | jq '.. | (.nodes? // empty)[] | select(.focused) | .id')

# Check if the focused window is in the scratchpad workspace
in_scratchpad=$(swaymsg -t get_tree | jq --argjson id "$focused_id" --arg ws "$workspace_name" 'recurse(.nodes[]) | select(.type=="workspace" and .name==$ws) | recurse(.nodes[]) | select(.id==$id) | .id')

# If the focused window is in the scratchpad workspace, move it to the original workspace
if [ -n "$in_scratchpad" ]; then
    swaymsg move container to workspace back_and_forth
else
    # Get the first window in the scratchpad workspace
    win_id=$(swaymsg -t get_tree | jq --arg ws "$workspace_name" 'recurse(.nodes[]) | select(.type=="workspace" and .name==$ws) | recurse(.nodes[]) | .id')

    # If there is a window in the scratchpad workspace, show it
    if [ -n "$win_id" ]; then
        swaymsg [con_id="$win_id"] focus
    else
        # If there are no windows in the scratchpad workspace, move the current window to it
        swaymsg move container to workspace "$workspace_name"
    fi
fi
