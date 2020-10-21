#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

source ${DIR}/select.sh
source ${DIR}/styling.sh

branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')
staged=$(git diff --name-only --cached)

# echo $staged

#echo $branch



printf "\n"
printf "\t${bold}${blue}GiG${reset}${bold}Commit${reset}"
printf "\n"
printf "\n"
# echo '\033[38;5;1mnormal \033[02;38;5;1mdim \033[01;38;5;1mbold'


# CURRENT TEAM
branchArray=(${branch//-/ })
question 'Team ID' $branchArray
read -p " " TEAM_ANSWER
TEAM="${TEAM_ANSWER:-$branchArray}"


# TICKET NUMBER
TICKET_NUMBER="${branch//[^0-9]/}"

question 'Ticket Number' $TICKET_NUMBER
read -p " " TICKET_ANSWER
TICKET="${TICKET_ANSWER:-$TICKET_NUMBER}"


# PACKAGE
PACKAGE_FOLDER=$(basename $PWD)
question 'Package name' $PACKAGE_FOLDER
read -p " " PACKAGE_ANSWER
PACKAGE="${PACKAGE_ANSWER:-$PACKAGE_FOLDER}"


# TYPE OF BRANCH
question "Type"
type_options=("feat" "fix" "bugfix" "test")
select_option "${type_options[@]}"
choice=$?
BRANCH_TYPE="${type_options[$choice]}"


# COMMIT MESSAGE
question "Commit Message"
read -p " " MESSAGE_ANSWER
MESSAGE=`echo "$MESSAGE_ANSWER" | awk '{ print tolower($1) }'`
COMMIT_MSG="git commit -m \"$BRANCH_TYPE($PACKAGE): $MESSAGE \" -m \"Closes #${TEAM}-${TICKET}\""


# SHOW COMMIT MESSAGE
question "Are you sure you want to commit;"
printf "\t${yellow}$COMMIT_MSG${reset}" 
printf "\t"
read -p "${blue}Y/n${reset}   " COMMIT_ANSWER
Y='y';
DO_COMMIT="${COMMIT_ANSWER:-$Y}"


# echo $DO_COMMIT

if [ "$DO_COMMIT" = 'y' ]; then
    echo 'Gonna commit it to your mother!'
$COMMIT_MSG
else 
    echo "Ok, you don't have to.."
fi
