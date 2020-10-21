#!/usr/bin/env bash

black=`tput setaf 0`
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
cyan=`tput setaf 6`
white=`tput setaf 7`
reset=`tput sgr0`
bold=`tput bold`
dim=`tput dim`

# printf "\t${bold}${blue}GiG${reset}${bold}Commit${reset}"



function question {
    if [[ ! -z "$2" ]]; then
        printf "\t${bold}${1}${reset} ${blue}($2)${reset} \n"
    else 
        printf "\t${bold}${1}${reset} \n"
    fi 
}