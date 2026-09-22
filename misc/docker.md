# Docker commands

## Rebuild a docker compose project with no cache
```
docker compose up -d --build --no-cache
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
