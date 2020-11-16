#!/bin/sh

# Add system properties for env variables defined in docker image:
CATALINA_OPTS="$CATALINA_OPTS \
-Dorg.apache.tomcat.util.digester.PROPERTY_SOURCE=org.apache.tomcat.util.digester.EnvironmentPropertySource \
-Dfile.encoding=UTF-8 \
-Dorg.apache.tomcat.util.digester.REPLACE_SYSTEM_PROPERTIES=true"
