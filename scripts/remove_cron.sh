#!/bin/bash

CRON_COMMAND='/usr/bin/node -r dotenv/config index.js'

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
