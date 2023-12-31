#!/bin/bash

# Get the source folder's full path.
SOURCE_FULL_PATH="$(realpath ../src/)"

# Change directory to the location of your Node.js program
cd $SOURCE_FULL_PATH

CRON_COMMAND="cd $SOURCE_FULL_PATH; node -r dotenv/config ./index.js"

# Check if the cron job is already present
if crontab -l | grep -q "$CRON_COMMAND"; then
    # Remove the cron job
    (crontab -l | grep -v "$CRON_COMMAND") | crontab -
    
    # Check if the cron job was successfully removed
    if crontab -l | grep -q "$CRON_COMMAND"; then
        echo "Failed to remove the cron job."
    else
        echo "Cron job removed successfully."
    fi
else
    echo "Cron job not found. No action taken."
fi
