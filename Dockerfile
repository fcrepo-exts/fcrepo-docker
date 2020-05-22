FROM tomcat:9-jdk11-openjdk

ENV TOMCAT_USERS_FILE=$CATALINA_HOME/conf/tomcat-users.xml \
    FEDORA_ADMIN_PASSWORD=fedoraAdmin \
    FCREPO_OCFL_STAGING_DIR=/var/lib/fcrepo/staging \
    FCREPO_OCFL_STORAGE_ROOT_DIR=/var/lib/fcrepo/ocfl \
    FCREPO_OCFL_WORK_DIR=/var/lib/fcrepo/work \
    FCREPO_ACTIVEMQ_DIRECTORY=/var/lib/fcrepo/activemq \
    FCREPO_AUDIT_CONTAINER=/audit

# Unclear if still used:
# fcrepo.home=/var/lib/fcrepo
# com.arjuna.ats.arjuna.common.ObjectStoreEnvironmentBean.default.objectStoreDir=arjuna.common.object.store
# com.arjuna.ats.arjuna.objectstore.objectStoreDir=arjuna.object.store

# Add webapp, scripts and config files: 
COPY tomcat/conf/* $CATALINA_HOME/conf/
COPY tomcat/bin/* $CATALINA_HOME/bin/setenv.sh

# Set permissions and create webapp directory
RUN chmod 744 $CATALINA_HOME/bin/setenv.sh \
    && chmod 600 $CATALINA_HOME/conf/tomcat-users.xml \
    && mkdir $CATALINA_HOME/webapps/fcrepo

COPY webapp $CATALINA_HOME/webapps/fcrepo


