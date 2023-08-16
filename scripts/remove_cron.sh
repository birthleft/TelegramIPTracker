#!/bin/bash

# Change directory to the location of your Node.js program
cd ../src/

# Get the program's full path.
PROGRAM_FULL_PATH="$(realpath index.js)"
CRON_COMMAND="/usr/bin/node -r dotenv/config $PROGRAM_FULL_PATH"

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
