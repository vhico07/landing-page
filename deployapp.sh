#!/bin/bash

echo "Make sure your code is tested!, the next step it'll deploy to staging and build in prod automaticly"

echo -n "ARE you sure (Y/N)?"

answered=

while [[ ! $answered ]]; do
    read -r -n 1 answer
    if [[ $answer = [Yy] ]]; then
        git checkout staging
        git merge master
        git push origin staging
        git checkout prod
        git merge staging
        git push prod
        git checkout master
    elif [[ $answer = [Nn] ]]; then
        answered="no"
    fi
done

# printf "\n%s\n" $answered