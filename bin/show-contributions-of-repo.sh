#!/bin/bash
echo $1
export GITHUB_API="https://srv-git-01-hh1.alinghi.tipp24.net/api/v3"
curl -s -X GET "$GITHUB_API/repos/hpo/$1/stats/contributors" > tmp
ADDITIONS="`cat tmp | jq '.[] | .weeks | map(.a) | add'`"
REMOVALS=`cat tmp | jq '.[] | .weeks | map(.d) | add'`
USERS=`cat tmp | jq '.[] | .author | .login'`
add_array=(${ADDITIONS// /})
sub_array=(${REMOVALS// /})
users_array=(${USERS// /})

for ((index=0;index<${#add_array[@]};++index)); do
  user=`printf "%-17s " "${users_array[$index]}"`
  add=`printf "%-5s " "${add_array[$index]}"`
  sub=`printf "%-5s " "${sub_array[$index]}"`
  echo "User: $user Additions: $add Removals: $sub"
done

rm tmp
