# build-env
This image is used in Bamboo to build, test, sign, and deploy [Nimbus Core](https://github.com/openanthem/nimbus-core). The settings file `settings-docker.xml` is included for that purpose.

The following applications are included to support the build, test, signature, and deployment processes:
* OpenJDK 1.8.191
* Maven 3.5.2
* GNUPG 2.2.4
* Git 2.17.1
* curl 7.58.0
* xpath 1.42.1
* NodeJS 8.15
* NPM 6.4.1
* Chromium 71.0.3578

## Getting started

1. Install [Docker](https://www.docker.com/products/docker-desktop).
2. Pull this image.

	    $ docker pull antheminc/build-env

## Usage

For example, from the root directory of the project you could build nimbus-parent:

```sh
docker run -it --rm --name build \
  -v $HOME:/root -v $PWD:/app -w=/app \
  antheminc/build-env \
    mvn -B clean install test -P cicdbuild \
      -Dgpg.skip -DskipDocker
```

Or nimbus-ui:

```sh
docker run -it --rm --name build \
  -v $HOME:/root -v $PWD:/app -w=/app \
  antheminc/build-env \
    mvn -B clean install -P devbuild,run-ui-tests -f nimbus-ui \
      -Dgpg.skip -DskipDocker
```