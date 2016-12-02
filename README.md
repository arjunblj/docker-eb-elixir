Building locally:

```sh
docker run -p 4000 --rm \
  --name app_development -i -t app
```

To set up AWS Elastic Beanstalk:

```sh
eb init
```

Keep the local env in sync (this can be done with `docker-compose`, alternatively):

```sh
eb local setenv HOST=http://localhost:4000 PORT=4000
```

Run:

```sh
eb local run --port 4000
```

Create a DB:

```sh
eb create \
  --database \
  -db.engine postgres \
  -db.i db.t2.small \
  -db.size 10 \
  -db.version 9.4.5 \
  --envvars MIX_ENV=prod, SECRET_KEY_BASE=SeCr3tk3Y, PORT=4000
```
