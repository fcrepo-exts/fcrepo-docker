FROM tomcat:8.5-jdk8

ENV CATALINA_HOME=/usr/local/tomcat \
    PATH=$CATALINA_HOME/bin:$PATH

## Dependencies
RUN GEN_DEP_PACKS="curl" && \
    echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
    apt-get update && \
    apt-get install -y --no-install-recommends $GEN_DEP_PACKS && \
    ## Cleanup phase.
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

### Fedora Install

ENV JMS_BROKER_URL=tcp://localhost:61616 \
    JAVA_MAX_MEM=${JAVA_MAX_MEM:-2G} \
    JAVA_MIN_MEM=${JAVA_MIN_MEM:-512M} \
    JAVA_OPTS='-Djava.awt.headless=true -server -Xmx${JAVA_MAX_MEM} -Xms${JAVA_MIN_MEM} -XX:+UseG1GC -XX:+UseStringDeduplication -XX:MaxGCPauseMillis=200 -XX:InitiatingHeapOccupancyPercent=70 -Djava.net.preferIPv4Stack=true -Djava.net.preferIPv4Addresses=true' \
    FCREPO_VERSION=${FCREPO_VERSION:-5.1.0} \
    FCREPO_HOME=/opt/fcrepo/data \
    FCREPO_CONFIG_DIR=/opt/fcrepo/config \
    # jdbc-mysql, jdbc-postgresql, file-simple
    FCREPO_MODESHAPE_TYPE=file-simple \
    FCREPO_AUDIT_CONTAINER=audit \
    FCREPO_SPRING_CONFIG=fcrepo-config.xml \
    FCREPO_DB_TYPE=nodb\
    FCREPO_DB=fcrepo \
    FCREPO_DB_USER=fedora \
    FCREPO_DB_PASSWORD=fedora_pw \
    FCREPO_DB_HOST=localhost \
    FCREPO_DB_PORT=3306 \
    FEDORA_USER=testuser \
    FEDORA_USER_PASSWORD=testpass \
    FEDORA_ADMIN=fedoraAdmin \
    FEDORA_ADMIN_PASSWORD=fedoraAdmin

# put all fcrepo opts in here for all configs
RUN echo 'JAVA_OPTS="$JAVA_OPTS -Dfcrepo.modeshape.configuration=classpath:/config/'$FCREPO_MODESHAPE_TYPE'/repository.json -Dfcrepo.'$FCREPO_DB_TYPE'.username='$FCREPO_DB_USER' -Dfcrepo.'$FCREPO_DB_TYPE'.password='$FCREPO_DB_PASSWORD' -Dfcrepo.'$FCREPO_DB_TYPE'.host='$FCREPO_DB_HOST' -Dfcrepo.'$FCREPO_DB_TYPE'.port='$FCREPO_DB_PORT' -Dfcrepo.home='$FCREPO_HOME' -Dfcrepo.admin='$FEDORA_ADMIN' -Dfcrepo.admin.password='$FEDORA_ADMIN_PASSWORD' -Dfcrepo.user='$FEDORA_USER' -Dfcrepo.user.password='$FEDORA_USER_PASSWORD' -Dfcrepo.audit.container=/'$FCREPO_AUDIT_CONTAINER'"' > $CATALINA_HOME/bin/setenv.sh && \
	chmod +x $CATALINA_HOME/bin/setenv.sh

# Install Fedora 5
ARG FCREPO_VERSION
ARG FCREPO_CONFIG_DIR
ARG FCREPO_HOME

# Download FCREPO war file and copy to tomcat/webapps dir
RUN cd /tmp \
	&& curl -fSL https://github.com/fcrepo4/fcrepo4/releases/download/fcrepo-$FCREPO_VERSION/fcrepo-webapp-$FCREPO_VERSION.war -o fcrepo.war \
	&& cp fcrepo.war /usr/local/tomcat/webapps/fcrepo.war

# Add the /opt/fcrepo directory and contents
COPY rootfs /

# Fix permissions on fcrepo dir for tomcat
RUN chmod -Rv 644  /opt/fcrepo/config

EXPOSE 8080

WORKDIR /opt/fcrepo 

CMD ["catalina.sh", "run"]
