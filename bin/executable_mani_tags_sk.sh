#!/bin/bash

# Path to your mani.yaml file
mani_yaml="mani.yaml"

# Extract project names from mani.yaml and feed them into sk
selected_projects=$(yq e '.projects | keys | .[]' "$mani_yaml" | sk -m)

# Exit if no projects were selected
if [ "$selected_projects" = "" ]; then
  echo "No projects selected."
  exit 1
fi

# Prompt for the action to perform (add or remove tags)
read -p "Do you want to (a)dd or (r)emove tags? " action

# Prompt for the tags to add or remove
read -p "Enter tags (comma-separated): " input_tags

# Convert the input tags to an array
IFS=',' read -ra tags <<< "$input_tags"

# Process each selected project
while IFS= read -r project; do
  echo "Processing project: $project"

  # Loop through the tags
  for tag in "${tags[@]}"; do
    if [[ "$action" == "a" ]]; then
      # Add the tag if it doesn't already exist
      existing_tags=$(yq e ".projects.$project.tags" "$mani_yaml")
      if [[ $existing_tags == "null" ]]; then
        yq e ".projects.$project.tags = [\"$tag\"]" -i "$mani_yaml"
      else
        yq e ".projects.$project.tags += [\"$tag\"] | .projects.$project.tags |= unique" -i "$mani_yaml"
      fi
      echo "Added tag '$tag' to $project"
    elif [[ "$action" == "r" ]]; then
      # Remove the tag if it exists
      yq e ".projects.$project.tags -= [\"$tag\"]" -i "$mani_yaml"
      echo "Removed tag '$tag' from $project"
    else
      echo "Invalid action specified. Use 'a' for add or 'r' for remove."
      exit 1
    fi
  done
done <<< "$selected_projects"
