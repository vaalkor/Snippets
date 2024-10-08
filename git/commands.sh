#!/bin/bash

git remote update --prune
git branch -r #show remote branches
git branch -a #show all branches
git branch -f ref1 ref2 #Force ref1 to point to ref2

# 0->0->0->0->0->master   =>  # 0->0->0->0->0->master->0->ref2
#  \0->0->ref1->0->ref2   =>  #  \0->0->ref1
git rebase onto master ref1 ref2

git checkout HEAD -- filename # to reset a single file.

git fetch origin 
git reset --hard origin/master # Basically what you'd intuitvely think is a "force pull"

# super useful... tells you if a path is ignored by .gitignore and which line of the thing 
git check-ignore --verbose 'some_path'

# Get date of current commit:
git show -s --format=%ci HEAD 
# To get it as a unix timestamp:
git show -s --format=%ct HEAD

# Parse a ref (tag, branch name, so on) to get the hash
git rev-parse HEAD

# Start a message but don't commit it. So you can see a nice diff.
git merge --no-commit --no-ff feature/200968
# Then:
git merge --abort

# Cherry pick compares a commit to its parent. Merge commits have more than 1 parent so you can use -m to select which parent to compare to.
git cherry-pick -m 1 "<commit_hash>"

# Pretty obvious what this one does...
git branch --sort=-committerdate