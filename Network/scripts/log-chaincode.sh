#!/bin/bash

# Check if a parameter is passed
if [ -z "$1" ]; then
  echo "Usage: $0 <search-string>"
  exit 1
fi

ln=${2:-"100"}

# Assign the search string to a variable
search_string=$1

# Use docker ps to find the container ID
container_id=$(docker ps --format '{{.ID}} {{.Names}}' | grep "$search_string" | awk '{print $1}' | head -n 1)

# Check if a container ID was found
if [ -z "$container_id" ]; then
  echo "No container found with name containing '$search_string'."
  exit 1
else
  # Check the logs of the container
  docker logs -f --tail $ln "$container_id"
fi
