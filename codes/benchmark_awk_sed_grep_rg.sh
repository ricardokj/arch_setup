#!/bin/bash
# https://stackoverflow.com/questions/75588420/how-to-grep-all-keywords-from-array-in-bash-script/

# Find these set of keyword(s) in log (male_players.csv)
filter_list1=("Premier League")
filter_list2=("Premier League" "ST, CF" "Injury Prone")

#######################################
# awk
#######################################

#echo -e "\nawk1"
# 1 keyword
#time awk -v w="$(printf '%s\n' "${filter_list1[@]}")" '
#  BEGIN {IGNORECASE = 1; split(w,res,"\n"); for(i in res) res[i] = "\\<" res[i] "\\>"}
#  {for(i in res) if($0 !~ res[i]) next; print}' "male_players.csv" > awk-extracted1.log

#echo -e "\nawk2"
# 3 keywords - A && B && C
#time awk -v w="$(printf '%s\n' "${filter_list2[@]}")" '
#  BEGIN {IGNORECASE = 1; split(w,res,"\n"); for(i in res) res[i] = "\\<" res[i] "\\>"}
#  {for(i in res) if($0 !~ res[i]) next; print}' "male_players.csv" > awk-extracted2.log


#######################################
# meu awk
#######################################

echo -e "\nmeu awk1"
# 1 keyword
time awk 'BEGIN {IGNORECASE = 1} /\<Premier League\>/' "male_players.csv" > meuawk-extracted1.log

echo -e "\nmeu awk2"
# 3 keywords - A && B && C
time awk 'BEGIN {IGNORECASE = 1} /\<Premier League\>/&&/\<ST, CF\>/&&/\<Injury Prone\>/' "male_players.csv" > meuawk-extracted2.log

#######################################
# sed
#######################################
# 1 keyword
printf -v sedcmd '/\\b%s\\b/{' "${filter_list1[@]}"
printf -v toadd '%*s' ${#filter_list1[@]}
echo -e "\nsed1"
time sed -ne "$sedcmd"p${toadd// /\}} < male_players.csv > sed-extracted1.log

# 3 keywords - A && B && C
printf -v sedcmd '/\\b%s\\b/{' "${filter_list2[@]}"
printf -v toadd '%*s' ${#filter_list2[@]}
echo -e "\nsed2"
time sed -ne "$sedcmd"p${toadd// /\}} < male_players.csv > sed-extracted2.log




#######################################
# meu sed
#######################################
# 1 keyword
echo -e "\nmeu sed1"
time sed -n '/\bPremier League\b/Ip' < male_players.csv > meused-extracted1.log

# 3 keywords - A && B && C
echo -e "\nmeu sed2"
time sed -n '/\bPremieR League\b/I{/\bST, CF\b/I{/\bInjury Prone\b/I{p}}}' male_players.csv > meused-extracted2.log


#######################################
# grep
#######################################
# 1 keyword
echo -e "\ngrep1"
time grep -Ewi 'Premier League' male_players.csv > grep-extracted1.log

# 3 keywords - A && B && C
echo -e "\ngrep2"
time grep -Ewi 'Premier League' male_players.csv | grep -Ewi 'ST, CF' | grep -Ewi 'Injury Prone' > grep-extracted2.log

#######################################
# ripgrep
#######################################
# 1 keyword
echo -e "\nrg1"
time rg -wi 'Premier League' male_players.csv > rg-extracted1.log

# 3 keywords - A && B && C
echo -e "\nrg2"
time rg -wi 'Premier League' male_players.csv | rg -wi 'ST, CF' | rg -wi 'Injury Prone' > rg-extracted2.log
