#!/bin/sh

PREVIOUS_HEAD=$1
NEW_HEAD=$2
BRANCH_SWITCH=$3

if [ $BRANCH_SWITCH == "1" -a $PREVIOUS_HEAD != $NEW_HEAD ]; then
    # Start from the repository root.
    cd ./$(git rev-parse --show-cdup)

    # Check if requirements have been updated - npm/yarn
    REQUIREMENTS=`git diff $PREVIOUS_HEAD $NEW_HEAD --name-status | grep "package.json"`
    if [ $? -eq "0" ]; then
        echo "\nThe requirements for this project may have changed. Update dependencies by running:"
        echo "  yarn install"
    fi
fi