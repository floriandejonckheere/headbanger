# Headbanger

Headbanger is a music recommendation and discovery platform.

## Migrating

Run the following commands to migrate the database.

```
$ rake db:migrate        # RDBMS
$ rake db:data:migrate   # Graph
```

## Setup

Make sure the following systems are running before starting the server:
 - Redis
 - Neo4J
 - PostgreSQL
