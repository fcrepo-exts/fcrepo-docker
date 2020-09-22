FROM tomcat:9-jdk11-openjdk

# escape \
ENV TOMCAT_USERS_FILE=$CATALINA_HOME/conf/tomcat-users.xml \
    FEDORA_ADMIN_USERNAME=fedoraAdmin \
    FEDORA_ADMIN_PASSWORD=fedoraAdmin \
    FCREPO_HOME=/var/lib/fcrepo \
    FCREPO_OCFL_STAGING=/var/lib/fcrepo/staging \
    FCREPO_OCFL_ROOT=/var/lib/fcrepo/ocfl-root  \
    FCREPO_OCFL_TEMP=/var/lib/fcrepo/ocfl-temp \
    FCREPO_ACTIVEMQ_DIRECTORY=/var/lib/fcrepo/activemq \
    FCREPO_DB_URL="jdbc:h2:/var/lib/fcrepo/data/fcrepo-h2\;FILE_LOCK=SOCKET"  \
    FCREPO_DB_USERNAME="" \
    FCREPO_DB_PASSWORD="" \
    FCREPO_ACTIVEMQ_DIRECTORY=/var/lib/fcrepo/activemq \
    FCREPO_AUDIT_CONTAINER=/audit

# Add webapp, scripts and config files: 
COPY tomcat/conf/* $CATALINA_HOME/conf/
COPY tomcat/bin/* $CATALINA_HOME/bin/setenv.sh

# Set permissions and create webapp directory
RUN chmod 744 $CATALINA_HOME/bin/setenv.sh \
    && chmod 600 $CATALINA_HOME/conf/tomcat-users.xml \
    && mkdir $CATALINA_HOME/webapps/fcrepo

COPY webapp $CATALINA_HOME/webapps/fcrepo
