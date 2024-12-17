# Really miscellaneous stuffs
## Useful curl options
`-s` (Silent mode)

`--location` (enables automatic redirection handling)

`-i` (Include HTTP headers in the output)

`-X METHOD` (Set the request method GET/POST/PUT...)

`-k` Accept self-signed certificates

## Using curl for uploading files via graphql
This command uploads local file `./someFile.csv` calling a graphql mutation called `someUploadMutation`:
```
curl \
  -H "Authorization: Bearer kiQoRd4tOk01LY-97RPMg-Qg..." \
  localhost:3000/graphql \
  -F operations='{ "query": "mutation ($fileUpload: Upload!, $requestId: String!) { someUploadMutation(fileUpload: $fileUpload, requestId: $requestId)}", "variables": { "fileUpload": null, "requestId": "bb40029e-39c9-4015-b1ee-16635b20c003" } }' \
  -F map='{ "0": ["variables.fileUpload"] }' \
  -F "0=@./someFile.csv;type=text/csv"
```
## Creating a PDF from image files
User imagemagick. 

On Linux (Ubuntu) install it with 

`sudo apt-get install imagemagick`.

On Mac 

`brew install imagemagick`

Then:

`convert -quality 60 *.jpg -auto-orient output.pdf`

## Displaying field names inside a PDF
We can use the `pdftk` tool via `docker`:

```docker run --rm --volume $(pwd):/work pdftk/pdftk:latest example.pdf dump_data_fields```

Here is a simple script to automate this task:
```bash
#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

FILE_PATH=$(realpath "$1")

DIR_PATH=$(dirname "$FILE_PATH")

BASE_NAME=$(basename "$1")

cd "$DIR_PATH" || exit 1

docker run --rm --volume "$(pwd)":/work pdftk/pdftk:latest "$BASE_NAME" dump_data_fields
```

## A really simple HTTP server
We can run a really simple HTTP server for testing purposes using Ruby:
```shell
ruby -run -ehttpd . -p8888
```

Here is another example using Python:
```shell
python3 -m http.server 9000
```
