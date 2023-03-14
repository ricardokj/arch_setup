#!/bin/bash

# Find these set of keyword(s) in log (male_players.csv)
filter_list1=("Premier League")
filter_list2=("Premier League" "ST, CF" "Injury Prone")

cmd (){
    echo ${1}: \
    `(time eval $2 > "$1"-extracted.log ) 2>&1 | sed -n 's/real\s*//gp' ` 
}

cmd "awk1"  "awk 'BEGIN {IGNORECASE = 1} /\<Premier League\>/' male_players.csv"
cmd "awk2"  "awk 'BEGIN {IGNORECASE = 1} /\<Premier League\>/&&/\<ST, CF\>/&&/\<Injury Prone\>/' male_players.csv"
cmd "sed1"  "sed -n '/\bPremier League\b/Ip' male_players.csv"
cmd "sed2"  "sed -n '/\bPremieR League\b/I{/\bST, CF\b/I{/\bInjury Prone\b/I{p}}}' male_players.csv"
cmd "grep1" "grep -Ewi 'Premier League' male_players.csv"
cmd "grep2" "grep -Ewi 'Premier League' male_players.csv | grep -Ewi 'ST, CF' | grep -Ewi 'Injury Prone'"
cmd "rg1"   "rg -wi 'Premier League' male_players.csv"
cmd "rg2"   "rg -wi 'Premier League' male_players.csv | rg -wi 'ST, CF' | rg -wi 'Injury Prone'"