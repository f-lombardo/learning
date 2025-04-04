# Notes on PHP and Symfony
## Symfony
### How to create a new migration based on differences with the current DB
```shell
bin/console doctrine:migrations:diff                  
```
### How to run just one Doctrine migration in Symfony
```shell
bin/console doctrine:migrations:execute --up "DoctrineMigrations\VersionyyyyMMddhhmmss"
```
### How to set up a brand-new DB
```shell
bin/console doctrine:database:create 
bin/console doctrine:schema:update --force
bin/console doctrine:migrations:sync-metadata-storage
echo yes | bin/console doctrine:migrations:version --add --all
```

### How to check the validity of Doctrine schema
```shell
bin/console doctrine:schema:validate --skip-sync
```

### Converting IEE 754 floating point numbers
```php
public function binary32Encode(float $f): string
{
    return bin2hex(pack('G', $f));
}

public static function binary32Decode(string $s): float
{
     $value=unpack('f',strrev(pack('H*',$s)));

     return $value[1];
}
```