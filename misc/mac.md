# Some notes for Mac users
## Updating homebrew
`brew update && brew upgrade && brew cleanup`

To test your installation:
`brew doctor`

## How to run non-notarized software
`xattr -r -d com.apple.quarantine /path/to/your/program`

Anyway a minor problem with notarization will manifest itself through a security dialogue appearing, explaining that the source of the program is not trusted.

## How to add a CA certificate to Mac Keychain
1. Locate where your certificate file is. It is likely to be somewhere near your web server configurations.
2. Open up Keychain Access. You can get to it from  `Application/Utilities/Keychain Access.app` .
3. Drag your certificate into Keychain Access.
4. Go into the Certificates section and locate the certificate you just added
5. Double-click on it, enter the trust section and under “When using this certificate” select “Always Trust”
   See [this document](https://tosbourn.com/getting-os-x-to-trust-self-signed-ssl-certificates/)
