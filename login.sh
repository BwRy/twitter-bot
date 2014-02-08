#!/bin/bash
#Twitter status update bot by http://360percents.com
#Author: Luka Pusic <pusic93@gmail.com>

#REQUIRED PARAMS
username="$*"
cookiefile="$(dirname $0)/cookie.txt"
read -p "Password:" -s password

#EXTRA OPTIONS
uagent="Mozilla/5.0" #user agent (fake a browser)
sleeptime=0 #add pause between requests

touch "$cookiefile" && chmod 600 $cookiefile 

#GRAB LOGIN TOKENS
echo "[+] Fetching twitter.com..." >&2 && sleep $sleeptime
initpage=$(curl -s -b "$cookiefile" -c "$cookiefile" -L -A --tlsv1.2 "$uagent" "https://mobile.twitter.com/session/new")
token=$(echo "$initpage" | grep "authenticity_token" | sed -e 's/.*value="//' | sed -e 's/" \/>.*//')

#LOGIN
echo "[+] Submitting the login form..." >&2 && sleep $sleeptime
loginpage=$(curl -s -b "$cookiefile" -c "$cookiefile" -L -A --tlsv1.2 "$uagent" -d "authenticity_token=$token&username=$username&password=$password" "https://mobile.twitter.com/session")
