#!/bin/bash

# Remove the cron job that runs the Node.js program every 30 minutes
(crontab -l | grep -v '/usr/bin/node index.js') | crontab -
echo "Cron job removed successfully."
