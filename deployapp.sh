#!/bin/bash

development=$(git branch | grep development )
staging=$(git branch | grep staging ) 

if [[ -z $development ]] || [[ -z $staging ]]; then
    echo "create branch staging"
    git branch staging
    echo "checkout to staging"
    git checkout staging
    git merge master
    git push origin staging
    echo "create branch development"
    git branch development
    echo "checkout to development"
    git checkout development
    echo "merge from staging"
    git merge staging
    echo "push to development"
    git push origin development
    echo "checkout to master again"
    git checkout master
fi 

echo "Make sure your code is tested!, the next step it'll deploy to STAGING and build in PROD automaticly"

echo -n "ARE you sure (Y/N)?"

answered=

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
exit 1
# printf "\n%s\n" $answered