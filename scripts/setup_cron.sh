#!/bin/bash

# Change directory to the location of your Node.js program
cd ../src/

# Set up the cron job to run the Node.js program every 30 minutes
(crontab -l 2>/dev/null; echo "*/30 * * * * /usr/bin/node index.js") | crontab -
echo "Cron job set up successfully."