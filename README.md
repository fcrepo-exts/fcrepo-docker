# The Official "Plain Vanilla" Fedora Repository Docker Files

## How to use

```
docker run -p8080:8080 --name=fcrepo fcrepo/fcrepo
```

The default configuration provides the following tomcat users:

Username | Role          | Default password | Description
-------- | ------------- | ---------------- | -----------
fedoraAdmin | fedoraAdmin | fedoraAdmin     | Has full privileges on fedora

If you need additional users or don't want to provide the password for fedoraAdmin via a environment variable, you can specify your own `tomcat-users.xml` file with the environment variable `TOMCAT_USERS_FILE`, e.g:

```
docker run -p8080:8080 -v/path/on/host/tomcat-users.xml:/tomcat-users.xml -e TOMCAT_USERS_FILE=/tomcat-users.xml --name=fcrepo fcrepo/fcrepo
```

By default the docker container writes all data to `/var/lib/fcrepo`. For persistent storage, this path should be declared as a volume, e.g:

```
docker run -p8080:8080 -v/path/on/host:/var/lib/fcrepo --name=fcrepo fcrepo/fcrepo
```

### Passing in configuration

Custom configuration can be passed into the docker container by using the following environment variables:

Variable | Default Value | Description
-------- | ------------- | -----------
`CATALINA_OPTS` | none |
`TOMCAT_USERS_FILE` | `$CATALINA_HOME/conf/tomcat-users.xml` | Specify a custom tomcat-users.xml file with e.g. additional users
`FCREPO_OCFL_STAGING_DIR` | `/var/lib/fcrepo/staging` | Set fcrepo.ocfl.staging.dir
`FCREPO_OCFL_STORAGE_ROOT_DIR` | `/var/lib/fcrepo/ocfl` | Set fcrepo.ocfl.storage.root.dir
`FCREPO_OCFL_WORK_DIR` | `/var/lib/fcrepo/work` | Set fcrepo.ocfl.work.dir
`FCREPO_AUDIT_CONTAINER` | `/audit` | Set fcrepo.audit.container
`FCREPO_SPRING_CONFIGURATION` | none | Specify a custom fcrepo.spring.configuration file
`FCREPO_ACTIVEMQ_CONFIGURATION` | none | Specify a custom fcrepo.activemq.configuration
`FCREPO_ACTIVEMQ_DIRECTORY` | `/var/lib/fcrepo/activemq` | Set fcrepo.activemq.directory
`FCREPO_AUTH_WEBAC_AUTHORIZATION` | none | Specify a custom root WebAC authentication fcrepo.activemq.configuration
`FCREPO_SPRING_AUDIT_CONFIGURATION` | none | Specify a custom fcrepo.spring.audit.configuration
`FCREPO_VELOCITY_RUNTIME_LOG` | none | Set fcrepo.velocity.runtime.log
`FEDORA_ADMIN_PASSWORD` | `fedoraAdmin` | If using the default tomcat-users.xml file: specify a custom password to for the user `fedoraAdmin`
`LOGBACK_CONFIGURATIONFILE` | none | Specify a custom logback.configurationFile

For a detailed explanation of the configuration options have a look at [Application Configuration](https://wiki.lyrasis.org/display/FEDORA6x/Application+Configuration) in the Lyrasis Wiki.

## Development

### Repository organisation

This repository is used to manage docker images for the Fedora Commons from Version 5.x onwards. The Dockerfile for the latest release of each major version is managed on separate branch. Currently the following are planned:

- `5.x-maintenance`: latest release of version 5 (coming soon)
- `master`: latest development snapshot

 ### Building the docker image locally

To build the docker image from a locally built snapshot of fcrepo-webapp, pass the path to the fcrepo-webapp-*.war to the build script:

```
./build.sh /path/to/fcrepo-webapp-6.0.0-SNAPSHOT.war
```

This will create a docker image fcrepo/fcrepo in your local docker repository.
