#!/bin/sh
{
set -x
    getmethods() {
        grep -E '^.[\a-zA-Z_-]+:.*?## .*$' Makefile | sed 's/^[.PHONY:].*: //g' | sort | awk '{split($0,l," ## "); printf "\033[01;31m%-30s\033[0m %s\n" "", l[1], l[2]; }'
    }
    getmethods
}
