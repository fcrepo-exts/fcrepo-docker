# The Official  Fedora Repository Docker Files

---

## Specifications

* Uses official Tomcat image: [tomcat:8.5-jdk8](https://github.com/docker-library/tomcat/blob/200fb67e66016f412b5e8428e48e7794dd7faae7/8.5/jdk8/openjdk/Dockerfile)

**Contains**:

* [Fedora](https://github.com/fcrepo4/fcrepo4/releases/tag/fcrepo-5.1.0) `5.1.0`
* [Tomcat](https://tomcat.apache.org/download-80.cgi)`8.5.x`
* [OpenJDK](https://openjdk.java.net/) `8`
  * Versions 11 & 13 on with Tomcat 9 fail using Fedora 5.
* Ability to configure modeshape within the ISLE 8 project `fedora.env`

---


# Building

In order to build locally, run this command

```
MINOR_VERSION=1
PATCH_VERSION=0
docker build -t "fcrepo/fcrepo:5.${MINOR_VERSION}.${PATCH_VERSION}" .
```

# Running

To run 
```
docker run -p8080:8080 --name "fcrepo:5.${MINOR_VERSION}.${PATCH_VERSION}"  "fcrepo/fcrepo:5.${MINOR_VERSION}.${PATCH_VERSION}"
```

To connect to the docker instance: 
```
docker exec -it "fcrepo-5.${MINOR_VERSION}.${PATCH_VERSION}" bash
```

# Interacting with Fedora 
You can access the Fedora HTML UI via the following url:
```
http://localhost:8080/fcrepo/rest
```
The default configuration provides the following tomcat users:

Username | Role          | Default password | Description
-------- | ------------- | ---------------- | -----------
fedoraAdmin | fedoraAdmin | fedoraAdmin     | Has full privileges on fedora
testuser |  fedoraUser | testpass | Has limited privileges but can be granted more using Web ACLs.

If you need additional users or don't want to provide the password for fedoraAdmin via a environment variable, you can specify your own `tomcat-users.xml` file with the environment variable `TOMCAT_USERS_FILE`, e.g:

```
docker run -p8080:8080 -v/path/on/host/tomcat-users.xml:/tomcat-users.xml -e TOMCAT_USERS_FILE=/tomcat-users.xml --name="fcrepo-5.${MINOR_VERSION}.${PATCH_VERSION}"  "fcrepo/fcrepo:5.${MINOR_VERSION}.${PATCH_VERSION}"
```

### Passing in configuration

Custom configuration can be passed into the docker container by using the following environment variables:

Variable | Default Value | Description
-------- | ------------- | -----------
`CATALINA_OPTS` | none |
`TOMCAT_USERS_FILE` | `$CATALINA_HOME/conf/tomcat-users.xml` | Specify a custom tomcat-users.xml file with e.g. additional users
`FCREPO_AUDIT_CONTAINER` | `/audit` | Set fcrepo.audit.container
`FCREPO_SPRING_CONFIGURATION` | none | Specify a custom fcrepo.spring.configuration file
`FCREPO_ACTIVEMQ_CONFIGURATION` | none | Specify a custom fcrepo.activemq.configuration
`FCREPO_ACTIVEMQ_DIRECTORY` | `/var/lib/fcrepo/activemq` | Set fcrepo.activemq.directory
`FCREPO_SPRING_AUDIT_CONFIGURATION` | none | Specify a custom fcrepo.spring.audit.configuration
`FEDORA_ADMIN` | `fedoraAdmin`| Specify a custom Fedora admin user name.
`FEDORA_ADMIN_PASSWORD` | `fedoraAdmin` | If using the default tomcat-users.xml file: specify a custom password to for the user `fedoraAdmin`
`FEDORA_USER` | `testuser`| Specify a custom Fedora user name.
`FEDORA_USER_PASSWORD` | `testpass` | If using the default tomcat-users.xml file: specify a custom password to for the user `testuser`
`LOGBACK_CONFIGURATIONFILE` | none | Specify a custom logback.configurationFile
`JMS_BROKER_URL` | tcp://localhost:61616 |
`JAVA_MAX_MEM` | 2G | max jvm heap
`JAVA_MIN_MEM` | 512M | min jvm heap
`FCREPO_VERSION` | 5.1.0 | Fedora Version
`FCREPO_HOME` | /opt/fcrepo/data | Fedora home directory
`FCREPO_CONFIG_DIR` | /opt/fcrepo/config | Fedora config directory
`FCREPO_MODESHAPE_TYPE` | file-simple | valid values:  jdbc-mysql, jdbc-postgresql, file-simple 
`FCREPO_SPRING_CONFIG` | fcrepo-config.xml | The swappable spring configuration
`FCREPO_DB_TYPE` | nodb| valid values:  mysql, postgresql
`FCREPO_DB` | fcrepo | The database name
`FCREPO_DB_USER` | fedora | The database user
`FCREPO_DB_PASSWORD` | fedora_pw | The database user password
`FCREPO_DB_HOST` | localhost |  The database host
`FCREPO_DB_PORT` | 3306 | The database port

For a detailed explanation of the configuration options have a look at [Application Configuration](https://wiki.lyrasis.org/display/FEDORA5x/Application+Configuration) in the Lyrasis Wiki
