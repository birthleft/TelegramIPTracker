const fs = require('fs');

// Require the dotenv package
require('dotenv').config();

const axios = require('axios');
const TelegramBot = require('node-telegram-bot-api');

// Create a ".env" file in the root directory of the project and add the following lines:
// BOT_TOKEN:YOUR_BOT_TOKEN
// CHAT_ID:YOUR_CHAT_ID

// Initialize the Telegram bot
const bot = new TelegramBot(process.env.BOT_TOKEN, { polling: false });

const ipFilePath = '.ip';

// Function to send Telegram message
function sendTelegramMessage(message) {
  bot.sendMessage(process.env.CHAT_ID, message)
    .then(() => {
      console.log('Telegram message sent successfully.');
    })
    .catch((error) => {
      console.error('Error sending Telegram message:', error);
    });
}

// Function to check IP address
async function checkIP() {
  try {
    const response = await axios.get('https://api64.ipify.org?format=json');
    const currentIP = response.data.ip;

    fs.readFile(ipFilePath, 'utf8', (err, previousIP) => {
      if (err || currentIP !== previousIP) {
        sendTelegramMessage(`Your IP address has changed. New IP: ${currentIP}`);
        console.log('IP address has changed. New IP: ' + currentIP);
        fs.writeFile(ipFilePath, currentIP, (err) => {
          if (err) {
            console.error('Error saving IP address:', err);
          } else {
            console.log('IP address saved.');
          }
        });
      } else {
        console.log('IP address has not changed.');
      }
    });
  } catch (error) {
    console.error('Error checking IP address:', error);
  }
}

// Initial check on program start
checkIP();