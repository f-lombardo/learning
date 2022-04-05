# Really miscellaneous stuffs
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