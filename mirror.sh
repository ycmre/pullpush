#!/bin/bash

set -euo pipefail

source ".env" # read env vars

echo "starting..."
WORKDIR="./repos"
mkdir -p "$WORKDIR"
cd "$WORKDIR"

while read -r SRC_URL; do
	REPO_NAME=$(basename "$SRC_URL" .git)
	echo "cloning into $SRC_URL -> $TARGET_USER/$REPO_NAME"
	rm -rf $REPO_NAME # remove old clones
	git clone --mirror "$SRC_URL" "$REPO_NAME"
	cd "$REPO_NAME"
	git push --mirror -u "git@github.com:$TARGET_USER/$REPO_NAME.git" # push directly to the url
	cd ..
	echo "$REPO_NAME done"
done < ../repos.txt
