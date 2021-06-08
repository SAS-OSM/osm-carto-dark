#!/bin/sh

# This script is used to start the import of kosmtik containers for the Docker development environment.
# You can read details about that in DOCKER.md

# Testing if database is ready
i=1
MAXCOUNT=60
echo "Waiting for PostgreSQL to be running"
while [ $i -le $MAXCOUNT ]
do
  pg_isready -q && echo "PostgreSQL running" && break
  sleep 2
  i=$((i+1))
done
test $i -gt $MAXCOUNT && echo "Timeout while waiting for PostgreSQL to be running"

case "$1" in
import)
  # Creating default database
  psql -c "SELECT 1 FROM pg_database WHERE datname = 'gis';" | grep -q 1 || createdb gis && \
  psql -d gis -c 'CREATE EXTENSION IF NOT EXISTS postgis;' && \
  psql -d gis -c 'CREATE EXTENSION IF NOT EXISTS hstore;' && \

  # Importing data to a database  
  if [ "${PROJECT_STYLE:-unset}" = "unset" ]
    then
      # No transforms
      osm2pgsql \
      --cache $OSM2PGSQL_CACHE \
      --number-processes $OSM2PGSQL_NUMPROC \
      --hstore \
      --multi-geometry \
      --database gis \
      --slim \
      --drop \
      $OSM2PGSQL_DATAFILE
    else
      # Transforms
      osm2pgsql \
      --cache $OSM2PGSQL_CACHE \
      --number-processes $OSM2PGSQL_NUMPROC \
      --hstore \
      --multi-geometry \
      --database gis \
      --slim \
      --drop \
      --style $PROJECT_PATH/$PROJECT_STYLE \
      --tag-transform-script $PROJECT_PATH/$PROJECT_LUA \
      $OSM2PGSQL_DATAFILE      
    fi

  # Downloading needed shapefiles
  scripts/get-external-data.py -c $PROJECT_PATH/$PROJECT_EXTDATA
  ;;

kosmtik)
  # Creating default Kosmtik settings file
  if [ ! -e ".kosmtik-config.yml" ]; then
    cp /tmp/.kosmtik-config.yml .kosmtik-config.yml
  fi
  export KOSMTIK_CONFIGPATH=".kosmtik-config.yml"

  # Starting Kosmtik
  kosmtik serve $PROJECT_PATH/$PROJECT_MML --host 0.0.0.0
  # It needs Ctrl+C to be interrupted
  ;;

esac
