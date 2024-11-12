#!/bin/bash


# Variables
REPO_DIR="/Users/aryansingh/Desktop/Anush_python"  # Change this to your repository path in Unix format
LOG_FILE="$REPO_DIR/version_history.log"


# Debugging: Print the repository directory
echo "Repository Directory: $REPO_DIR"


# Change to the repository directory
cd "$REPO_DIR" || { echo "Repository not found!"; exit 1; }


# Debugging: Confirm we're in the right directory
echo "Successfully changed to repository directory."


# Ask the user for the filename they want to commit
read -p "Enter the name of the file to commit (with relative path): " FILE_NAME


# Check if the file exists
if [ ! -f "$FILE_NAME" ]; then
    echo "Error: File '$FILE_NAME' does not exist."
    exit 1
fi


# Get the current date and time in the format "YYYY-MM-DD HH:MM:SS"
CURRENT_DATE=$(date +"%Y-%m-%d %H:%M:%S")


# Use the current date and time as the commit message
COMMIT_MESSAGE="Commit on $CURRENT_DATE - File: $FILE_NAME"


# Debugging: Show the commit message
echo "Commit Message: $COMMIT_MESSAGE"


# Stage the specific file for commit
git add "$FILE_NAME" || { echo "Error adding file to staging area."; exit 1; }


# Commit the changes with the current date and time as the message
git commit -m "$COMMIT_MESSAGE" || { echo "Commit failed."; exit 1; }


# Get the commit hash (optional, but useful for logging)
COMMIT_HASH=$(git log -1 --format=%h)


# Debugging: Show the commit hash
echo "Commit Hash: $COMMIT_HASH"


# Log the commit with the date, time, and commit hash
echo "$CURRENT_DATE - $COMMIT_MESSAGE - Commit Hash: $COMMIT_HASH" >> "$LOG_FILE" || { echo "Failed to write to log file."; exit 1; }


echo "Commit successful! Logged to $LOG_FILE"