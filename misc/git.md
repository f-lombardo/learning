# Git
## Search in git files
`git rev-list --all | xargs git grep -F "$1"`

or 

`git grep "search string" $(git rev-list --all)`

The above command searches in all files in all branches, even in dismissed ones.

## Clean local branches based on remote status
```bash
#!/bin/bash
set -x #echo on
echo "Cleaning up old branches..."
git remote prune origin 
git branch -vv | grep 'origin/.*: gone]' | awk '{print $1}' | xargs git branch -d
echo "...done!"
```
## How to squash a group of commits
If you want to squash your last 3 commits in just one:
`git rebase -i HEAD~3`
Then, if you have already pushed (and you are sure nobody else pushed in the meanwhile :-)
`git push -f`

## How to recover a deleted git stash
- Search the commit number associated to your deleted stash. For example, if you know it was done on top of commit `abcd`, you can write:

`git fsck 2> /dev/null | awk '/commit/{print $3}' | git show --stdin --grep 'WIP on master: abc'`

otherwise try just with

`git fsck 2> /dev/null | awk '/commit/{print $3}' | git show --stdin --grep 'WIP'`
- Having found the commit number of your stash, say `123aaa`, apply it with

`git stash apply 123aaa`

See https://mobilejazz.com/blog/how-to-recover-a-deleted-git-stash/

## How to checkout a file from a previous commit
1. Identify the commit SHA
```
git log -- path/to/file
```
2. Checkout the file
```
git checkout <commit-sha> -- path/to/file
```

## Change "origin" of your GIT repository
```
git remote rm origin
git remote add origin git@github.com:aplikacjainfo/proj1.git
git config master.remote origin
git config master.merge refs/heads/master
```

## Using personal access tokens for cloning a repository
```
git clone https://your_user_id:your_token@coderepo.com/some_path_to/your_project.git
```
## Ignoring files just for your current copy of the repository
You can ignore particular files that are just on your machine without messing up `.gitignore` by adding them in file
`.git/info/exclude`.

## Using multiple SSH keys to access Github
Edit `~/.ssh/config` file this way
```
Host gh.work
    HostName github.com
    IdentityFile ~/.ssh/key_for_work

Host gh.personal
    HostName github.com
    IdentityFile ~/.ssh/key_for_personal_use
```
The `Host` is how you will reference credentials on your terminal. To test your connection try `ssh -T git@<myHost>`.
Then you can clone your repos using the host vars you specified before:
```
git clone git@<myHost>:user-name/reponame.git
```
To change an already cloned repository use:
```
git remote remove origin
git remote add origin git@<myHost>:user-name/reponame.git
```

Please remember to set up `user.email` and `user.name` correctly:
```shell
git config --local user.email yours@email.test
```

Here is a bash function you can add to your .profile file to create an alias for cloning a repo with your personal account:
```bash
ghp ()
{
    url=$1

    username=$(echo "$url" | cut -d':' -f2- | cut -d'/' -f1)
    repository=$(echo "$url" | rev | cut -d'/' -f1 | rev | cut -d'.' -f1)

    git clone git@gh.personal:$username/$repository.git
    cd $repository

    git config --local user.email your.persoonal@mai.test
    git config --local user.name "Your Name" 
    
}
```


## AWS CodeCommit
To be able to use CodeCommit repositories you could add this section to your  ~/.gitconfig  file:

```
[credential]
    helper = !aws --profile my-profile codecommit credential-helper $@
    useHttpPath = true
```

We suppose here that you already have `my-profile` profile configured for the aws command.

After this, if you want to add  CodeCommit as a new remote for your current project, you can run this command:
```
git remote add codecommit https://git-codecommit.region-name.amazonaws.com/v1/repos/my-repo
```

And then push to it with
```
git push comdecommit my-branch
```
If you are using Mac OS, remember to periodically run this script before pushing to CodeCommit (about every 15 minutes)
```
security delete-internet-password -l git-codecommit.eu-west-1.amazonaws.com
```
See this [post for more information on the problem](https://docs.aws.amazon.com/codecommit/latest/userguide/troubleshooting-ch.html).

## How to count number of commits per day
```
git log --date=short --pretty=format:%ad | sort | uniq -c
```

## Mirroring everything from a local repository to github
```
git push --mirror https://github.com/EXAMPLE-USER/EXAMPLE-REPO.git
```

## Add a different remote for Open Source merging
```
git remote add new_remote git@github.com:user_name/project_name.git
```

```
git fetch new_remote 
```

```
git checkout -b branch_name --track new_remote/branch_name
```

```
git push origin branch_name
```
