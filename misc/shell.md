# A short list of useful shell commands

## Basics

##### Differences between two directories
`diff -qr dir1 dir2`

##### Find a string in files with a certain suffix
`find . -name '*.kt' -type f | xargs grep "MyString"`

##### Read file updates in real time
`tail -f` 

##### Open a file in nano without using line wrap
`nano -w` 

##### Display line numbers in less
`less -N`

##### Display line numbers in nano
`nano -c`

Otherwise, you could press `Ctrl-c` during editing to show current position. 

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

### Set VAR to "foo" if VAR is unset or the empty string

`: ${VAR:=foo}`


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

## IntelliJ
##### Run a subset of tests
Here are some patterns that can be handy to run some kind of tests from IntelliJ:
* `.*E2E.*` -> runs only tests that have E2E in their name
* `^(?!.*IT$).*$` -> excludes tests that have IT in their name


## Misc
A sample script for [adding comments in typescript sources](add_comments.sh).