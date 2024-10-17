FROM tomcat:9-jdk11-temurin

# escape \
ENV TOMCAT_USERS_FILE=$CATALINA_HOME/conf/tomcat-users.xml \
    FEDORA_ADMIN_USERNAME=fedoraAdmin \
    FEDORA_ADMIN_PASSWORD=fedoraAdmin

# Add webapp, scripts and config files: 
COPY tomcat/conf/* $CATALINA_HOME/conf/
COPY tomcat/bin/* $CATALINA_HOME/bin/setenv.sh

# Set permissions and create webapp directory
RUN chmod 744 $CATALINA_HOME/bin/setenv.sh \
    && chmod 600 $CATALINA_HOME/conf/tomcat-users.xml \
    && mkdir $CATALINA_HOME/webapps/fcrepo

COPY webapp $CATALINA_HOME/webapps/fcrepo
