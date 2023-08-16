#!/bin/bash

# Get the source folder's full path.
SOURCE_FULL_PATH="$(realpath ../src/)"

# Change directory to the location of your Node.js program
cd $SOURCE_FULL_PATH

CRON_COMMAND="cd $SOURCE_FULL_PATH; node -r dotenv/config ./index.js"

npm install

# Check if the cron job is already set up for the Node.js program
if ! crontab -l | grep -q "$CRON_COMMAND"; then
	# Install Node.js program
	npm install
    # Set up the cron job to run the Node.js program every 30 minutes
    (crontab -l 2>/dev/null; echo "*/30 * * * * $CRON_COMMAND") | crontab -
    # Check if the cron job has been added successfully
    if crontab -l | grep -q "$CRON_COMMAND"; then
        echo "Cron job set up successfully."
    else
        echo "Failed to set up cron job."
    fi
else
    echo "Cron job is already set up."
fi