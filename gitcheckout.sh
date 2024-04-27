#!/bin/bash

# Check if git is initialized
if [ -f ~/.bggit/remote_repo ]; then
    REMOTE_REPO=$(cat ~/.bggit/remote_repo)
else
    echo "git not initialised"
    exit
fi

# Find the commit that matches the input
commit=$(find ~/.bggit/.stor -maxdepth 1 -type d -name "$1*" | head -n 1)

# Check if a commit was found
if [ -n "$commit" ]; then
    echo "Restoring to commit: $(basename $commit)"
    # Remove all files and subdirectories in the remote repository
    rm -rf $REMOTE_REPO/*
    # Copy the contents of the commit directory to the remote repository
    cp -R $commit/. $REMOTE_REPO
else
    echo "No such commit."
fi