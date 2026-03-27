# Notes on security keys

## Using a Google Titan for authorizing sudo

1. Install the `libpam-u2f` package:

```shell
sudo apt install libpam-u2f
```

2. Register the key:

```shell
pamu2fcfg > ~/.config/Yubico/u2f_keys
```

3. Enable the key:

Edit `/etc/pam.d/sudo`:

```
# Add next line before the @include common-auth
auth sufficient pam_u2f.so
@include common-auth
```
