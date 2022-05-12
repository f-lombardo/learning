# Notes on Typescript and Node
## Node
### Adding a local cache for packages
We could use [npm-proxy-cache](https://github.com/runk/npm-proxy-cache)

1. Install the package:
```bash
npm install npm-proxy-cache -g`
```
2. Configure npm to use proxy:
```bash
npm config set proxy http://localhost:8099/
npm config set https-proxy http://localhost:8099/
npm config set strict-ssl false
```
3. Create a directory for hosting cache, for example:
```bash
mkdir ~/npm-proxy-cache`
```
5. Run cache manager:
```bash
npm-proxy-cache -p 8099 -e -t 36000 -s ~/npm-proxy-cache
```
### Some environment variables for nodejs
Setting the following variable can bypass problems during https connections, such as handling self-signed or expired certificates: 
```
NODE_TLS_REJECT_UNAUTHORIZED=0
```
---
With this setting we ask node to display logs for the listed modules (in this example tls, https and http).
```
NODE_DEBUG=tls,https,http
```
## Typescript
### Adding import aliases in Node
There are three steps for using [import aliases](https://github.com/labs42io/clean-code-typescript#use-typescript-aliases) with node:
1. Add `baseUrl` and `path` options to `tsconfig.json`, for example:
```
    "baseUrl": "./",
    "paths": {
      "@my_app_appservices/*": ["src/appservices/*"],
      "@my_app_consts/*": ["src/consts/*"],
      }
```
2. Add `moduleMapper` option to [`jest` configuration](https://kulshekhar.github.io/ts-jest/docs/getting-started/paths-mapping/).
For example, if you configure `jest` in `package.json`, you could write something like this:
```
  "jest": {
    "moduleNameMapper": {
      "^@my_app_appservices/(.*)$": "<rootDir>/src/appservices/$1",
      "^@my_app_consts/(.*)$": "<rootDir>/src/consts/$1",
```
3. Since [`tsc` doesn't compile alias path](https://stackoverflow.com/questions/59179787/tsc-doesnt-compile-alias-paths),
we should use [`tsc-alias`](https://github.com/justkey007/tsc-alias), changing our build script this way: 
```
"build": "tsc && tsc-alias"
```



