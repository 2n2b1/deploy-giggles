#!/bin/sh
#commit-msg
{
    # Translate files in directory into comma delimited list
    # ls -A -d * | tr -s "\n" ","
    #
    # Translate files in dir into comma list, then pass into another program via stdin
    # ls -A -d * | tr -s "\n" "," | xargs -d ","; echo $@;
    # 
    # List of unstages (but new?) files
    # files=$(git status -s | grep "\?\?" | cut -c3- | tr -s "\n" ","); echo ${files:0:(-1)};
    #
    set -e
    #linter=$(make linter)
    #define linter
    files=$(git diff --cached --name-only)
    if [ "$files" = "" ];
    then
        exit 0;
    fi
    for file in ${files}; do
        result=$(git show :$file | linter)
    done
}
