#!/bin/bash

echo "Usage: ionvcs <command> [args]"
echo
printf "%-15s %-20s %-30s\n" "Command" "Args" "Description"
printf "%-15s %-20s %-30s\n" "-------" "-----" "-----------"
printf "%-15s %-20s %-30s\n" "clone" "<repo-url>" "Clone a repository."
printf "%-15s %-20s %-30s\n" "user" "<username>" "Get user information."
printf "%-15s %-20s %-30s\n" "init" "N/A" "Initialize a repository."
printf "%-15s %-20s %-30s\n" "login" "N/A" "Login to the system."
printf "%-15s %-20s %-30s\n" "push" "[-f]" "Push changes to the repository."
