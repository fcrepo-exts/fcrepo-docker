#!/bin/sh

# Add system properties for env variables defined in docker image:
CATALINA_OPTS="$CATALINA_OPTS \
-Dfile.encoding=UTF-8 \
-Dorg.apache.tomcat.util.digester.PROPERTY_SOURCE=org.apache.tomcat.util.digester.EnvironmentPropertySource \
-Dfcrepo.ocfl.staging.dir=$FCREPO_OCFL_STAGING_DIR \
-Dfcrepo.ocfl.storage.root.dir=$FCREPO_OCFL_STORAGE_ROOT_DIR \
-Dfcrepo.ocfl.work.dir=$FCREPO_OCFL_WORK_DIR \
-Dfcrepo.audit.container=$FCREPO_AUDIT_CONTAINER"

# Only add these system properties, if the env variable is defined:

if [ ! -z "$FCREPO_SPRING_CONFIGURATION" ] ; then
  CATALINA_OPTS="$CATALINA_OPTS -Dfcrepo.spring.configuration=$FCREPO_SPRING_CONFIGURATION"
fi

if [ ! -z "$FCREPO_ACTIVEMQ_CONFIGURATION" ] ; then
  CATALINA_OPTS="$CATALINA_OPTS -Dfcrepo.activemq.configuration=$FCREPO_ACTIVEMQ_CONFIGURATION"
else
  CATALINA_OPTS="$CATALINA_OPTS -Dfcrepo.activemq.directory=$FCREPO_ACTIVEMQ_DIRECTORY"
fi

if [ ! -z "$FCREPO_AUTH_WEBAC_AUTHORIZATION" ] ; then
  CATALINA_OPTS="$CATALINA_OPTS -Dfcrepo.auth.webac.authorization=$FCREPO_AUTH_WEBAC_AUTHORIZATION"
fi

if [ ! -z "$FCREPO_SPRING_AUDIT_CONFIGURATION" ] ; then
  CATALINA_OPTS="$CATALINA_OPTS -Dfcrepo.spring.audit.configuration=$FCREPO_SPRING_AUDIT_CONFIGURATION"
fi

if [ ! -z "$LOGBACK_CONFIGURATIONFILE" ] ; then
  CATALINA_OPTS="$CATALINA_OPTS -Dlogback.configurationFile=$LOGBACK_CONFIGURATIONFILE"
fi

if [ ! -z "$FCREPO_VELOCITY_RUNTIME_LOG" ] ; then
  CATALINA_OPTS="$CATALINA_OPTS -Dfcrepo.velocity.runtime.log=$FCREPO_VELOCITY_RUNTIME_LOG"
fi
