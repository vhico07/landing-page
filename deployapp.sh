#!/bin/bash

development=$(git branch | grep development ) 

if [[ -z $development ]]; then
    echo "create branch development"
    git branch development
    echo "checkout to development"
    git checkout development
    echo "merge from master"
    git merge master
    echo "push to development"
    git push origin development
    echo "checkout to master again"
    git checkout master
    exit 1
fi 

echo "Make sure your code is tested!, the next step it'll deploy to staging and build in prod automaticly"

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

# printf "\n%s\n" $answered