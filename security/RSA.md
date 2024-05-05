# How to encrypt a file using RSA with openssl

### 1. Generate a key pair
```bash
openssl genrsa -out pub_priv_pair.key 3072
```

### 2. Extract public key
```bash
openssl rsa -in pub_priv_pair.key -pubout -out pub_key.key
```

### 3. Encrypt file using public key
```bash
openssl rsautl -encrypt -pubin -inkey pub_key.key -in plain_file.txt -out cipher.bin -oaep
```

### 4. Optionally convert encrypted file in base64
```bash
openssl base64 -in cipher.bin -out cipher.txt
```

To convert encrypted file back from base64 to its original binary format use
```bash
openssl base64 -d -in cipher.txt -out cipher.bin
```

### 5. To decode file use
```bash
openssl rsautl -decrypt -inkey pub_priv_pair.key -in cipher.bin -out decoded.txt -oaep
```