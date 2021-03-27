#!/bin/bash

development=$(git branch | grep development ) 

echo "Make sure your code is tested!, the next step it'll deploy to staging and build in prod automaticly"

echo -n "ARE you sure (Y/N)?"

answered=

if [[ -z $development ]]; then
    git branch development
else 
    git checkout development
    git merge master
    git push origin development
    git checkout master
fi     

while [[ ! $answered ]]; do
    read -r -n 1 answer
    if [[ $answer = [Yy] ]]; then
        git checkout staging
        git merge master
        git push origin staging
        git checkout master
        exit 1
    elif [[ $answer = [Nn] ]]; then
        answered="no"
    fi
done

# printf "\n%s\n" $answered