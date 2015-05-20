#!/bin/sh

set -x

gosu postgres postgres --single -E <<EOSQL
CREATE DATABASE template_postgis
UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template_postgis'
EOSQL

gosu postgres postgres --single template_postgis -E <<EOSQL
CREATE EXTENSION postgis
CREATE EXTENSION postgis_topology
EOSQL
