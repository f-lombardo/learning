# How to encrypt and decrypt a file using a symmetric key with Openssl

### Encryption
```bash
openssl enc -aes-256-ctr -pbkdf2 -e -a -in plain_file.txt -out encrypted.txt
```

Here is a description of parameters:
enc: encode/decode with symmetric key
-aes-256-ctr encode using aesn(block mapping funcion), 256 bit blocks, crt block cipher
-pbkdf2 key deriving algorithm
-e encode
-a convert result to base64

The above command will ask you for a password. If you want to send password to openssl via command line you can use
```bash
openssl enc -aes-256-ctr -pbkdf2 -e -a -in plain_file.txt -out encrypted.txt -pass file:<( echo -n "my_secret_password")
```

### Decription
```bash
openssl enc -aes-256-ctr -pbkdf2 -d -a -in encrypted.txt  -out decrypted.txt
```