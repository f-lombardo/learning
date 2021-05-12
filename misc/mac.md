# Some notes for Mac users
## Updating homebrew
`brew update && brew upgrade && brew cleanup`

To test your installation:
`brew doctor`

## How to run non-notarized software
`xattr -r -d com.apple.quarantine /path/to/your/program`

Anyway a minor problem with notarization will manifest itself through a security dialogue appearing, explaining that the source of the program is not trusted.
