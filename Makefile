CURRENT_DIR=$(shell basename $(PWD))

default: help

.PHONY: clean ## Clean up after the build process.
clean:docker-clean 

.PHONY: lint ## Lint all of the files for this Action.
lint:shell-lint 

.PHONY: build ## Build this Action.
build:docker-build 

.PHONY: test ## Test the components of this Action.
test:shell-test 

.PHONY: publish ## Publish this Action.
publish:docker-publish 

.PHONY: environment ## Displays information related to the state of this environment.
info:get-info

.PHONY: setup ## Define necessary credentials for third party services
setup:setup-tools
	@(call $(shell git config --global core.autocrlf input))

.PHONY: dev-all
dev-all:lint build test

.PHONY: shell-lint 
shell-lint: 
	@shellcheck -s sh *.sh */*.sh

.PHONY: fix-lint
fix-lint:
	if [ -s $(shell shellcheck -s sh *.sh */*.sh) ]; then { do sed -i -e "s/\r//g" $$file; }

help:
	@echo "\n\tHelpful Tip:\t\n\n\tStart with command 'make setup'. \n\tFurther Information at: $(REPO_URL)\n\n"
	@printf "\t\033[36m%-30s %s\n" "Command" "What it does..."
	@grep -E '^.[\a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sed 's/^[.PHONY:].*: //g' | sort | awk '{split($$0,l," ## "); printf "\t\033[01;31m%-30s\033[0m %s\n" "", l[1], l[2]; }'
	@printf "\n"