#!/bin/bash

CREDSFILE="$HOME/ionsrc/creds.txt"

read -p "Enter source IP/URL: " src;
read -p "Enter your username: " username;
read -sp "Enter your password: " password;

echo "";

echo "src=$src" > "$CREDSFILE";
echo "username=$username" >> "$CREDSFILE";
echo "password=$password" >> "$CREDSFILE";

# Secure the file
chmod 600 "$CREDSFILE";

echo -e "Logged in as \e[0;32m$username\e[0m!";
exit;