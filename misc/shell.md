# A short list of useful shell commands

## Basics

##### Differences between two directories
`diff -qr dir1 dir2`

## Git
##### Search in git files
`git rev-list --all | xargs git grep -F "$1"`

##### Clean local branches based on remote status
```bash
#!/bin/bash
set -x #echo on
echo "Cleaning up old branches..."
git remote prune origin 
git branch -vv | grep 'origin/.*: gone]' | awk '{print $1}' | xargs git branch -d
echo "...done!"
```
