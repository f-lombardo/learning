# A short list of useful shell commands

## Basics

##### Differences between two directories
`diff -qr dir1 dir2`

##### Find a string in files with a certain suffix
`find . -name '*.kt' | xargs grep "MyString"`

##### Read file updates in real time
`tail -f` 

##### Open a file in nano without using line wrap
`nano -w` 

##### Display line numbers in less
`less -N`

##### Display line numbers in nano
`nano -c`

Otherwise you could press `Ctrl-c` during editing to show current position. 

##### Extraxt the nth line from a file
`sed 'NUMq;d' sourcefile`

where NUM is the number of the name and sourcefile is the name of the file.

A faster way of doing this is:
`tail -n+NUM sourcefile | head -1`

See: https://stackoverflow.com/questions/6022384/bash-tool-to-get-nth-line-from-a-file

#### Write the output of a terminal session in a text file
The `script` command redirects all session output to a file called `typescript` in the current directory. 
You can specify a different file name with:
`script myFileName`

### Find your public IP address
`curl ifconfig.me`

#### A sample prompt
```shell
export LSCOLORS=gxfxcxdxbxegedabagacad
export CLICOLOR=1

light_green="\[\e[1;32m\]"
light_red="\[\e[1;31m\]"
yellow="\[\e[0;33m\]"
gray="\[\e[0;37m\]"
cyan="\[\e[0;36m\]"
reset="\[\e[m\]"

export PS1="\$([ \$? == 0 ] && echo ✅ || echo ❌ ) ${cyan}\w${reset} \$${reset} "
```

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
##### How to squash a group of commits
If you want to squash your last 3 commits in just one:
`git rebase -i HEAD~3`
Then, if you have already pushed (and you are sure nobody else pushed in the meanwhile :-)
`git push -f`

##### How to recover a deleted git stash
- Search the commit number associated to your deleted stash. For example, if you know it was done on top of commit `abcd`, you can write:

`git fsck 2> /dev/null | awk '/commit/{print $3}' | git show --stdin --grep 'WIP on master: abc'`

otherwise try just with

`git fsck 2> /dev/null | awk '/commit/{print $3}' | git show --stdin --grep 'WIP'`
- Having found the commit number of your stash, say `123aaa`, apply it with

`git stash apply 123aaa`

See https://mobilejazz.com/blog/how-to-recover-a-deleted-git-stash/

#### Change "origin" of your GIT repository 
```
git remote rm origin
git remote add origin git@github.com:aplikacjainfo/proj1.git
git config master.remote origin
git config master.merge refs/heads/master
```

#### Using personal access tokens for cloning a repository
```
git clone https://your_user_id:your_token@coderepo.com/some_path_to/your_project.git
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
