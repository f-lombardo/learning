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


