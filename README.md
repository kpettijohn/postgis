# PostGIS 

[![dockeri.co](http://dockeri.co/image/kpettijohn/postgis)](https://registry.hub.docker.com/u/kpettijohn/postgis)

## What is PostGIS?

PostGIS is a spatial database extender for PostgreSQL object-relational database. It adds support for geographic objects allowing location queries to be run in SQL.

## How to use this image

The `postgis` image is built using the official [postgres](https://registry.hub.docker.com/_/postgres/) Docker image.

Starting a `postgis` container.

```
docker run --name postgis -p "5432:5432" -d kpettijohn/postgis:9.4
```

Once the server is running you can connect to it directly using `psql`.

```
psql -h `docker-machine ip` -U postgres -l

                                    List of databases
       Name       |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
------------------+----------+----------+------------+------------+-----------------------
 postgres         | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0        | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
                  |          |          |            |            | postgres=CTc/postgres
 template1        | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
                  |          |          |            |            | postgres=CTc/postgres
 template_postgis | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
(4 rows)
```

You can also use `docker exec`:

```
docker exec postgis psql -U postgres -l

                                    List of databases
       Name       |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
------------------+----------+----------+------------+------------+-----------------------
 postgres         | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0        | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
                  |          |          |            |            | postgres=CTc/postgres
 template1        | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
                  |          |          |            |            | postgres=CTc/postgres
 template_postgis | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
(4 rows)
```

On run the container will create a database template called `template_postgis`. You can then use the `template_postgis` template to create your databases with the extensions `postgis` and `postgis_topology` pre-installed.

```
docker exec postgis psql -U postgres -c "CREATE DATABASE my_postgis_db TEMPLATE template_postgis;"

docker exec postgis psql -U postgres -d my_postgis_db -c "\dx"
                                         List of installed extensions
       Name       | Version |   Schema   |                             Description
------------------+---------+------------+---------------------------------------------------------------------
 plpgsql          | 1.0     | pg_catalog | PL/pgSQL procedural language
 postgis          | 2.1.7   | public     | PostGIS geometry, geography, and raster spatial types and functions
 postgis_topology | 2.1.7   | topology   | PostGIS topology spatial types and functions
(3 rows)
```

**Note**

If the `postgis` container exits on or shortly after running you may need to set a higher wait time to let the server start.

```
docker run --name postgis -p "5432:5432" -e "WAIT=5" -d kpettijohn/postgis:9.4
```
