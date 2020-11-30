# A short list of useful shell commands

## Basics

##### Differences between two directories
`diff -qr dir1 dir2`

##### Read file updates in real time
`tail -f` 

##### Open a file in nano without using line wrap
`nano -w` 

##### Display line numbers in nano
`nano -c`

Otherwise you could press `Ctrl-c` during editing to show current position. 

##### Extraxt the nth line from a file
`sed 'NUMq;d' sourcefile`

where NUM is the number of the name and sourcefile is the name of the file.

A faster way of doing this is:
`tail -n+NUM sourcefile | head -1`

See: https://stackoverflow.com/questions/6022384/bash-tool-to-get-nth-line-from-a-file

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
## Maven
##### Run Maven test with a particular locale configuration
To run maven tests with a particular locale configuration, you should set the `_JAVA_OPTIONS` environment variable. 
For example, if you use bash, you add this line to `.bash_profile`:

`export _JAVA_OPTIONS='-Duser.language=en -Duser.country=US'`

##IntelliJ
##### Run a subset of tests
Here are some patterns that can be handy to run some kind of tests from IntelliJ:
* `.*E2E.*` -> runs only tests that have E2E in their name
* `^(?!.*IT$).*$` -> excludes tests that have IT in their name
