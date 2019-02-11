# Jupyter Lab - Platform

Dockerfile allowing to build a Docker image based on Ubuntu 18.04 for the "Platform" project.

### Description

Provides the following prerequisites:

* Python 3.7.2
* Jupyter Lab + Widgets
* Couchbase libraries

Modules:

* beautifulsoup4
* couchbase
* dateutils
* lxml
* pillow
* psycopg2
* PyJWT
* requests
* toml
* xlrd
* xlwt
* xmldict

## Build Image

```shell
$ docker build -t jupyter-platform:latest .
```

## Run Container

Creating the container requires volume mapping and exposing HTTP port (both are `guest:docker`).

Runnning container from a locally built image:

```shell
$ docker run --name platformlab -d -p 8888:8888 -v /path/to/guest/notebooks:/root jupyter-platform
```

Running container from a remote image:

```shell
$ docker run --name platformlab -d -p 8888:8888 -v /path/to/guest/notebooks:/root bzaczynski/jupyter-platform
```

To start an existing container (previously named "platformlab"):

```shell
$ docker start platformlab
```

## Modify Running Container

In order to add a new Python module without rebuilding the entire image nor recreating the container:

```shell
$ docker exec -it platformlab /bin/bash
root@:~# python3.7 -m pip install some-module
```

## Push Image to Docker Hub

```shell
$ docker login
$ docker tag jupyter-platform:latest bzaczynski/jupyter-platform:latest
$ docker push bzaczynski/jupyter-platform:latest
```
