# Running OpenStreetMap Carto with Docker

[Docker](https://docker.com) is a virtualized environment running a [_Docker daemon_](https://docs.docker.com/engine/docker-overview), in which you can run software without altering your host system permanently. The software components run in _containers_ that are easy to set up and tear down individually. The Docker daemon can use operating-system-level virtualization (Linux, Windows) or a virtual machine (macOS, Windows).

This allows you to set up a development environment for OpenStreetMap Carto easily. Specifically, this environment consists of a [PostGIS](https://postgis.net/) database to store the OpenStreetMap data and [Kosmtik](https://github.com/kosmtik/kosmtik) for previewing the style.

## Prerequisites

Docker is available for Linux, macOS and Windows. [Install](https://www.docker.com/get-docker) the software packaged for your host system in order
to be able to run Docker containers. You also need Docker Compose, which should be available once you installed
Docker itself. Otherwise you need to [install Docker Compose manually](https://docs.docker.com/compose/install/).

You need sufficient disk space of _several gigabytes_. Docker creates a disk image for its virtual machine that holds the virtualised operating system and the containers. The format (Docker.raw, Docker.qcow2, \*.vhdx, etc.) depends on the host system. It can be a sparse file allocating large amounts of disk space, but still the physical size starts with 2-3 GB for the virtual OS and grows to 6-7 GB when filled with the containers needed for the database, Kosmtik, and a small OSM region. Further 1-2 GB are needed for shape files in the openstreetmap-carto/data repository.

<div id="quick_start"></div>

## Quick start

If you are eager to get started, here is an overview over the necessary steps.
Read on below to get the details.

1. `git clone https://github.com/davidwkelley/openstreetmap-carto.git` to clone the openstreetmap-carto repository into a directory on your host system. On Windows systems, append `--config core.autocrlf=input` to preserve Unix-style line endings.
2. `docker volume create --name=osm-data` to create an external volume to contain the database
3. Download OpenStreetMap data in [PBF](https://wiki.openstreetmap.org/wiki/PBF_Format) format to a file `data.osm.pbf`, and place it within the openstreetmap-carto directory (for example, some small area from [Geofabrik](https://download.geofabrik.de/)).
4. `docker-compose up db` to start PostgreSQL running (only necessary the first time or when you change the data file)
5. `docker-compose up import` to import the data (only necessary the first time or when you change the data file)
6. `docker-compose up kosmtik` to run the style preview application. Wait for kosmtik to issue the log message `... [Core] Map ready`.
7. Browse to <http://localhost:6789> to view the output of Kosmtik.
8. `Ctrl+C` to stop the style preview application
9. `docker-compose down` to stop and remove containers

## Repositories

Instructions above will clone main OpenStreetMap Carto repository. To test your own changes you should [fork](https://help.github.com/articles/fork-a-repo/) [davidwkelley/openstreetmap-carto](https://github.com/davidwkelley/openstreetmap-carto) repository and [clone your fork](https://help.github.com/articles/cloning-a-repository/).

This OpenStreetMap Carto repository needs to be a directory that is shared between your host system and the Docker virtual machine. Home directories are shared by default; if your repository is in another place you need to add this to the Docker sharing list (e.g. macOS: Docker Preferences > File Sharing; Windows: Docker Settings > Shared Drives).

## Creating an external volume

OpenStreetMap Carto needs a database populated with rendering data in order to
work. We store the database in an external volume so that it will persist indefinitely. We do that with `docker volume create --name=osm-data`.

You may customize the volume name as you see fit, but if you do, you must tell Docker Compose about it by setting `PGVOLUME` in the `.env` file.

By default the database is written to /var/lib/postgresql/data in the
volume, which is [standard practice](https://hub.docker.com/_/postgres). You may modify the location by setting `PGDATA` in the `.env` file.

You can list available volumes with `docker volume ls`.

## Importing data

Once you have an external volume set up, you need a data file to import.
It's probably easiest to grab a PBF of OSM data from [Geofabrik](https://download.geofabrik.de/).
Once you have that file, put it into the openstreetmap-carto directory and run `docker-compose up db` followed by `docker-compose up import` in the openstreetmap-carto directory.
This starts the PostgreSQL container (downloads it if it not exists) and starts a container that runs [osm2pgsql](https://github.com/openstreetmap/osm2pgsql) to import the data. The container is built the first time you run that command if it does not exist.
At startup of the container, the script `scripts/docker-startup.sh` is invoked, which prepares the database and itself starts osm2pgsql for importing the data.

osm2pgsql has a few [command line options](https://manpages.debian.org/testing/osm2pgsql/osm2pgsql.1.en.html), and the import by default uses a RAM cache of 512 MB, 1 worker, and expects the import file to be named `data.osm.pbf`. If you want to customize any of these parameters you have to set the environment variables `OSM2PGSQL_CACHE` (e.g. `export OSM2PGSQL_CACHE=1024` on Linux to set the cache to 1 GB) for the RAM cache (the value depends on the amount of RAM you have available, the more you can use here the faster the import may be), `OSM2PGSQL_NUMPROC` for the number of workers (this depends on the number of processors you have and whether your harddisk is fast enough e.g. is a SSD), or `OSM2PGSQL_DATAFILE` if your file has a different name.

You can also [tune the PostgreSQL](https://wiki.postgresql.org/wiki/Tuning\_Your\_PostgreSQL\_Server) during the import phases, with `PG_WORK_MEM` (default to 16MB) and `PG_MAINTENANCE_WORK_MEM` (default to 256MB), which will eventually write `work_mem` and `maintenance_work_mem` to the `postgresql.auto.conf` once, making them applied each time the database started. Note that unlike osm2pgsql variables, once thay are set, you can only change them by running `ALTER SYSTEM` on your own, changing `postgresql.auto.conf` or removing the database volume by `docker-compose down -v` and importing again.

If you want to customize and remember the values, set them in the `project.env`
file in the project directory:

    PG\_WORK\_MEM=128MB
    PG\_MAINTENANCE\_WORK\_MEM=2GB
    OSM2PGSQL\_CACHE=2048
    OSM2PGSQL\_NUMPROC=4
    OSM2PGSQL\_DATAFILE=taiwan.osm.pbf

<br/>Don't confuse the `project.env` file with the `.env` file. Variables
defined in the `.env` file pertain only to `docker.compose.yml`, which declares to Docker Compose how to manage the containers. Variables defined
in the `project.env` file pertain to the processes running *in* the containers. Furthermore, there's only one `.env` file, whereas there is a `project.env` file for each project.

Depending on your machine and the size of the extract, the import can take a while. When it is finished, you should have the data necessary to render it with OpenStreetMap Carto.

## Testing default style rendering

After you have the necessary data available, you can start Kosmtik to produce a test rendering. For that you run `docker-compose up kosmtik` in the openstreetmap-carto directory. This starts a container with Kosmtik and also starts the PostgreSQL database container if it is not already running. The Kosmtik container is built the first time you run that command if it does not exist.
At startup of the container, the script `scripts/docker-startup.sh` is invoked, which downloads necessary shapefiles with `scripts/get-external-data.py` (if they are not already present). Afterwards it runs Kosmtik. If you have to customize anything, you can do so in the script. The Kosmtik config file can be found in `.kosmtik-config.yml`.
If you want to have a [local configuration](https://github.com/kosmtik/kosmtik#local-config) for your `project.mml`, you can place a `localconfig.js` or `localconfig.json` file into the openstreetmap-carto directory.

The shapefile data that is downloaded is owned by the user with UID 1000. If you have another default user id on your system, consider changing the line `USER 1000` in the file `Dockerfile`.

After startup is complete, you can browse to <http://localhost:6789> to view the output of Kosmtik. By pressing `Ctrl+C` on the command line, you can stop the container. The PostgreSQL database container is still running then (you can check with `docker ps`). If you want to stop the database container as well, you can do so by running `docker-compose stop db` in the openstreetmap-carto directory.  To stop and remove all running containers, say `docker-compose down`.

## Testing OSM Black and White style rendering

The OpenStreetMap Carto Black and White style is a grayscale style derived from
the default style. As such, it works fine with external volume `osm-data`.

This style is found in the OSM-CartoBW subdirectory of the
openstreetmap-carto directory. If you'd like to test grayscale style rendering,
then:

1. Specify the location of the OSM-CartoBW project by setting `PROJECTENV=OSM-CartoBW/project.env` in the `.env` file, and by setting `PROJECT_PATH=OSM-CartoBW` in the subdirectory `project.env` file.
2. Follow steps #6 and remaining in the [Quick start](#quick_start) section.

## Testing HDM-CartoCSS style rendering

The [HDM](https://github.com/hotosm/HDM-CartoCSS) rendering is a Carto project focusing on the [Humanitarian Data Model](https://wiki.openstreetmap.org/wiki/Humanitarian\_OSM\_Tags). The HDM style is found in the HDM-CartoCSS subdirectory of the openstreetmap-carto directory. If you'd like to test HDM style rendering, then:

1. Specify the location of the HDM project by setting `PROJECTENV=HDM-CartoCSS/project.env` in the `.env` file, and by setting `PROJECT_PATH=HDM-CartoCSS` in the subdirectory `project.env` file.
2. Create an external volume for the HDM database, e.g. `hdm-data`.
3. Specify the volume name in the `.env` file.
4. Follow steps #3 and remaining in the [Quick start](#quick_start) section.

You may wonder why we need to create `hdm-data` when we already have `osm-data`.
That's because the style defines the database schema, and the schemas for the
default style and the HDM-CartoCSS style are incompatible. If you try to
render `osm-data` with the HDM-CartoCSS style, you'll get PostgreSQL errors.

## Rolling your own style

It's possible to create your own style. Because Carto CSS styles are complex,
you should start with the default style rather than try to make a new style
from scratch. The easiest way to do that is simply to edit the existing style.
That would be [project.mml](https://cartocss.readthedocs.io/en/latest/mml.html) in the openstreetmap-carto directory, along with the [.mss](https://ircama.github.io/osm-carto-tutorials/editing-guidelines/#cartocss-mss-stylesheets) files in the style subdirectory.

You can tell Kosmtik to reload a map after you've edited the style. That's the typical workflow.

If you wish to create a separate named style, then follow these steps:

1. Create a subdirectory, e.g. MyStyle.
2. Copy these files/directories to MyStyle: `external-data.yml`, `openstreetmap-carto.lua`, `openstreetmap-carto.style`, `project.env`, `project.mml`, `style`, `symbols`.
3. Specify `name: MyStyle` in `project.mml` in the subdirectory.
4. Specify the location of the MyStyle project by setting `PROJECTENV=MyStyle/project.env` in the `.env` file, and by setting `PROJECT_PATH=MyStyle` in the subdirectory `project.env` file.
5. Create an external volume for the MyStyle database, or just reuse `osm-data`.
6. Specify the volume name in the `.env` file.
7. Follow steps #3 and remaining in the [Quick start](#quick_start) section.

## Troubleshooting

* Importing the data needs a substantial amount of RAM in the virtual machine. If you find the import process being _killed_ by the Docker daemon (exiting with error code 137), increase the memory assigned to Docker (e.g. macOS: Docker Preferences / Windows: Docker Settings > Advanced > Adjust the computing resources).
<br/><br/>Docker copies log files from the virtual machine into the host system; their [location depends on the host OS](https://stackoverflow.com/questions/30969435/where-is-the-docker-daemon-log). E.g. the 'console-ring' appears to be a ringbuffer of the console log, which can help to find reasons for killings.<br/>

* While installing software in the containers and populating the database, the disk image of the virtual machine grows in size by Docker allocating more clusters. When the disk on the host system is full (only a few MB remaining), Docker can appear stuck. Watch the system log files of your host system for failed allocations.<br/><br/>Docker stores its disk image by default in the home directories of the user. If you don't have enough space there, you can move it elsewhere. (E.g. macOS: Docker > Preferences > Disk).<br/>

* Occasionally `docker-compose up db` will fail unexpectedly initially.  If so, rerun the command and the PostgreSQL container should come up with no problems.
