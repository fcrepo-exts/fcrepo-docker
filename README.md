# The Official "Plain Vanilla" Fedora Repository Docker Files

## How to use

```
docker run -p8080:8080 --name=fcrepo fcrepo/fcrepo
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

## Development

This repository is used to manage docker images for the Fedora Commons from Version 5.x onwards. The Dockerfile for the latest release of each major version is managed on separate branch. Currently the following are planned:

- `5.x-maintenance`: latest release of version 5
- `6.x-maintenance`: latest release of version 6
- `master`: latest development snapshot
