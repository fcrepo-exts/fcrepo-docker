#!/bin/sh

# Add system properties for env variables defined in docker image:
CATALINA_OPTS="$CATALINA_OPTS \
-Dorg.apache.tomcat.util.digester.PROPERTY_SOURCE=org.apache.tomcat.util.digester.EnvironmentPropertySource \
-Dfile.encoding=UTF-8 \
-Dorg.apache.tomcat.util.digester.REPLACE_SYSTEM_PROPERTIES=true \
-Dfcrepo.audit.container=$FCREPO_AUDIT_CONTAINER"

# Only add these system properties, if the env variable is defined:
if [ ! -z "$FCREPO_HOME" ] ; then
  CATALINA_OPTS="$CATALINA_OPTS -Dfcrepo.home=$FCREPO_HOME"
fi

if [ ! -z "$FCREPO_OCFL_STAGING" ] ; then
  CATALINA_OPTS="$CATALINA_OPTS -Dfcrepo.ocfl.staging=$FCREPO_OCFL_STAGING"
fi

if [ ! -z "$FCREPO_OCFL_ROOT" ] ; then
  CATALINA_OPTS="$CATALINA_OPTS -Dfcrepo.ocfl.root=$FCREPO_OCFL_ROOT"
fi

if [ ! -z "$FCREPO_OCFL_TEMP" ] ; then
  CATALINA_OPTS="$CATALINA_OPTS -Dfcrepo.ocfl.temp=$FCREPO_OCFL_TEMP"
fi

if [ ! -z "$FCREPO_DB_URL" ] ; then
  CATALINA_OPTS="$CATALINA_OPTS -Dfcrepo.db.url=$FCREPO_DB_URL"
fi 

if [ ! -z "$FCREPO_DB_USERNAME" ] ; then
  CATALINA_OPTS="$CATALINA_OPTS -Dfcrepo.db.user=$FCREPO_DB_USERNAME"
fi

if [ ! -z "$FCREPO_DB_PASSWORD" ] ; then
  CATALINA_OPTS="$CATALINA_OPTS -Dfcrepo.db.password=$FCREPO_DB_PASSWORD"
fi

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
