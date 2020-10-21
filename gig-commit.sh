#!/bin/bash

source ./select.sh

branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')
staged=$(git diff --name-only --cached)

# echo $staged

#echo $branch


# black=`tput setaf 0`
# red=`tput setaf 1`
# green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
# magenta=`tput setaf 5`
# cyan=`tput setaf 6`
# white=`tput setaf 7`
reset=`tput sgr0`
bold=`tput bold`
dim=`tput dim`

printf "\n"
printf "\t${bold}${blue}GiG${reset}${bold}Commit${reset}"
printf "\n"
printf "\n"
# echo '\033[38;5;1mnormal \033[02;38;5;1mdim \033[01;38;5;1mbold'


# CURRENT TEAM
branchArray=(${branch//-/ })
printf "\t${bold}Team ID${reset} ${blue}($branchArray)${reset} \n"
read -p " " TEAM_ANSWER
TEAM="${TEAM_ANSWER:-$branchArray}"


# TICKET NUMBER
TICKET_NUMBER="${branch//[^0-9]/}"
printf "\t${bold}Ticket Number${reset} ${blue}($TICKET_NUMBER)${reset} \n"
read -p " " TICKET_ANSWER
TICKET="${TICKET_ANSWER:-$TICKET_NUMBER}"


# PACKAGE
PACKAGE_FOLDER=$(basename $PWD)
printf "\t${bold}Package name${reset} ${blue}($PACKAGE_FOLDER)${reset} \n"
read -p " " PACKAGE_ANSWER
PACKAGE="${PACKAGE_ANSWER:-$PACKAGE_FOLDER}"


# TYPE OF BRANCH
printf "\t${bold}type${reset} ${blue}${reset} \n"
type_options=("feat" "fix" "bugfix" "test")
select_option "${type_options[@]}"
choice=$?
BRANCH_TYPE="${type_options[$choice]}"


# COMMIT MESSAGE
printf "\t${bold}Commit Message${reset} "
read -p " " MESSAGE_ANSWER
MESSAGE=`echo "$MESSAGE_ANSWER" | awk '{ print tolower($1) }'`
COMMIT_MSG="git commit -m \"$BRANCH_TYPE($PACKAGE): $MESSAGE \" -m \"Closes #${TEAM}-${TICKET}\""


# SHOW COMMIT MESSAGE
printf "\n"
printf "\t${yellow}$COMMIT_MSG${reset}" 
printf "\t"
read -p "Do you want to commit? ${blue}Y/n${reset}   " COMMIT_ANSWER
Y='y';
DO_COMMIT="${COMMIT_ANSWER:-$Y}"


# echo $DO_COMMIT

if [ "$DO_COMMIT" = 'y' ]; then
    echo 'Gonna commit it to your mother!'
$COMMIT_MSG
else 
    echo "Ok, you don't have to.."
fi
