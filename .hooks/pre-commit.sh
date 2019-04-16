#!/bin/sh

{
set -x

STAGED_JS_FILES=$(git diff --cached --name-only --diff-filter=ACM * | tr '\n' ' ')
[ -z "$STAGED_JS_FILES" ]


# Git pre commit hook. ---------------------------------------------------------
# Runs Prettier on staged .js files
echo "** Formatting Javascript files..."
# Prettify all staged .js files
echo "$STAGED_JS_FILES" | xargs ./node_modules/.bin/prettier --write
# Add back the modified/prettified files to staging
echo "$STAGED_JS_FILES" | xargs git add


# Git pre commit hook. ---------------------------------------------------------
# Runs ESLint on staged .js or .jsx files
# STAGED_JS_FILES=$(git diff --cached --name-only --diff-filter=ACM | grep ".js\{0,1\}$")
RED='\033[1;31m'
GREEN='\033[0;32m'
NC='\033[0m'
PASS=true

if [[ "$STAGED_JS_FILES" = "" ]]; then
  echo "\n** No files are currently staged."
  exit 0
fi

echo "\n** Linting files..."
for FILE in $STAGED_JS_FILES
do
  ./node_modules/.bin/eslint "$FILE"

  if [[ "$?" != 0 ]]; then
    PASS=false
  fi
done

if ! $PASS; then
  echo "\n${RED}COMMIT FAILED:${NC}\n\tYour commit contains files that should pass ESLint but do not. Please fix the ESLint errors and try again.\n\tTo override this validation, use --no-validate"
  exit 1
else
  echo "\n${GREEN}COMMIT SUCCEEDED${NC}"
fi
