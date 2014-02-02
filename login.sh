#!/bin/bash
#Twitter status update bot by http://360percents.com
#Author: Luka Pusic <pusic93@gmail.com>

#REQUIRED PARAMS
username="$*"
echo "Password:"
read -s password

#EXTRA OPTIONS
uagent="Mozilla/5.0" #user agent (fake a browser)
sleeptime=0 #add pause between requests

touch "cookie.txt" #create a temp. cookie file

#GRAB LOGIN TOKENS
echo "[+] Fetching twitter.com..." && sleep $sleeptime
initpage=$(curl -s -b "cookie.txt" -c "cookie.txt" -L -A "$uagent" "https://mobile.twitter.com/session/new")
token=$(echo "$initpage" | grep "authenticity_token" | sed -e 's/.*value="//' | sed -e 's/" \/>.*//')

#LOGIN
echo "[+] Submitting the login form..." && sleep $sleeptime
loginpage=$(curl -s -b "cookie.txt" -c "cookie.txt" -L -A "$uagent" -d "authenticity_token=$token&username=$username&password=$password" "https://mobile.twitter.com/session")
