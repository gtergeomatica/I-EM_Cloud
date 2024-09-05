# I-EM Cloud


## Docker dev commands

```sh
docker compose --env-file template.env --env-file .env down
```

```sh
docker compose --env-file template.env --env-file .env build
```

```sh
docker compose --env-file template.env --env-file .env up
```

## Popolate db

```sh
psql -v ON_ERROR_STOP=0 --username "postgres" -d ${DBNAME} < ${DUMPPATH}/bkp_data_2024-01-21.sql
```
