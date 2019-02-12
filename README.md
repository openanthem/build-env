# build-env
This image is used in Bamboo to build, test, sign, and deploy [Nimbus Core](https://github.com/openanthem/nimbus-core). The settings file `settings-docker.xml` is included for that purpose.

The following applications are included to support the build, test, signature, and deployment processes:
* Java 1.8
* Maven 3.5
* GNUPG
* git
* curl
* NodeJS 8.15
* NPM 6.4.1
* Chrome/Chromium 71

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