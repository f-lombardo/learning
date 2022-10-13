# Notes on Java
## Passing a default locale to JVM
`export _JAVA_OPTIONS='-Duser.language=en -Duser.country=US'`

## How to install Java on Mac
1. Download a tar.gz version (for example from [java.net](https://jdk.java.net))
2. `sudo tar xvzf ~/Downloads/openjdk-xxx.tar.gz -C /Library/Java/JavaVirtualMachines`
3. Install jenv: `brew install jenv`
4. Add these two lines to .zhrc
```shell
export PATH="$HOME/.jenv/bin:$PATH"'
eval "$(jenv init -)"
```
5. `jenv add /Library/Java/JavaVirtualMachines/jdkxxx/Contents/Home`