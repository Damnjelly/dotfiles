#!/bin/sh
if [ -z "$(git status -s -uno | grep -v '^ ' | awk '{print $2}')" ]; then
	gum confirm "Stage all?" && git add .
fi

GITMES=$(gum input --placeholder "commit message")
git commit -m "$GITMES"

git push
