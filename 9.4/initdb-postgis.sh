#!/bin/sh

set -x

WAIT=${WAIT:-3}

gosu postgres postgres -E -c listen_addresses='' &

sleep $WAIT

gosu postgres psql <<EOSQL
CREATE DATABASE template_postgis;
UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template_postgis';
\c template_postgis
CREATE EXTENSION postgis;
CREATE EXTENSION postgis_topology;
EOSQL

gosu postgres /usr/lib/postgresql/$PG_MAJOR/bin/pg_ctl stop
