#!/bin/bash
#Twitter status update bot by http://360percents.com
#Author: Luka Pusic <pusic93@gmail.com>

#REQUIRED PARAMS
read tweet #must be less than 140 chars
cookiefile="$(dirname $0)/cookie.txt"

#EXTRA OPTIONS
uagent="Mozilla/5.0 (X11; Linux i686) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36" #user agent (fake a browser)
sleeptime=0 #add pause between requests

touch "$cookiefile" #create a temp. cookie file

#GRAB COMPOSE TWEET TOKENS
echo "[+] Getting compose tweet page..." >&2 && sleep $sleeptime
composepage=$(curl -s -b "$cookiefile" -c "$cookiefile" -L -A --tlsv1.2 "$uagent" "https://mobile.twitter.com/compose/tweet")

#TWEET
echo "[+] Posting a new tweet: $tweet..." >&2 && sleep $sleeptime
tweettoken=$(echo "$composepage" | grep "authenticity_token" | sed -e 's/.*value="//' | sed -e 's/" \/>.*//' | tail -n 1)
update=$(curl -s -b "$cookiefile" -c "$cookiefile" -L -A --tlsv1.2 "$uagent" -d "authenticity_token=$tweettoken&tweet[text]=$tweet&tweet[display_coordinates]=false" "https://mobile.twitter.com/")
