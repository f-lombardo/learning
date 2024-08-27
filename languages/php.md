# Notes on PHP and Symfony
## Symfony
### How to create a new migration based on differences with the current DB
```shell
bin/console doctrine:migrations:diff                  
```
### How to run just one Doctrine migration in Symfony
```shell
bin/console doctrine:migrations:execute --up yyyyMMddhhmmss
```
### How to set up a brand-new DB
```shell
bin/console doctrine:database:create 
bin/console doctrine:schema:update --force
bin/console doctrine:migrations:sync-metadata-storage
echo yes | bin/console doctrine:migrations:version --add --all
```
