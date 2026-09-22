# Docker commands

## Rebuild a docker compose project with no cache
```
docker compose build --no-cache && docker compose up -d
```

## Check docker compose configuration
```
docker compose config
```

If you want to check configuration in a script use:
```shell
if docker compose config --quiet; then
  echo "Valid conf"
else
  echo "Invalid conf"
fi
```
