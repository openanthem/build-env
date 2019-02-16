FROM ubuntu:bionic

LABEL maintainer="Anthem OSS <anthemopensource@webteks.com>" \
    org.label-schema.vendor="Anthem, Inc." \
    org.label-schema.name="Nimbus Bamboo Container" \
    org.label-schema.description="Bamboo Docker Runner image for Anthem Nimbus" \
    org.label-schema.url="https://hub.docker.com/r/antheminc/build-env" \
    org.label-schema.vcs-url="https://github.com/openanthem/build-env" \
    org.label-schema.version="1.0.0" \
    org.label-schema.build-date="2019-02-16T12:38:35-05:00" \
    org.label-schema.schema-version="1.0"

COPY mvn-entrypoint.sh /usr/local/bin/mvn-entrypoint.sh
COPY settings-docker.xml /usr/share/maven/ref/
COPY setup_8.x /usr/local/setup_8.x

ENV BUILD_ENV=1.0.0 \
    NODE_ENV=development \
    MAVEN_HOME=/usr/share/maven \
    MAVEN_CONFIG=/root/.m2 \
    CHROME_BIN=/usr/bin/chromium-browser \
    JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 \
    PATH=$PATH:/usr/lib/jvm/java-8-openjdk-amd64/bin:/usr/lib/jvm/java-8-openjdk-amd64/jre/bin

RUN TINI_V="v0.18.0" && TINI_DL="https://github.com/krallin/tini/releases/download" \
    && apt-get -q update && apt-get install --no-install-recommends -y gnupg1 \
    && cat /usr/local/setup_8.x | bash - && apt-get install -y nodejs \
    && curl -sL -o /tini ${TINI_DL}/${TINI_V}/tini && chmod +x /tini \
    && apt-get install --no-install-recommends -y git openjdk-8-jdk maven chromium-browser \
    && ln -s "/usr/bin/gpg1" "/usr/bin/gpg" \
    && chmod +x /usr/local/bin/mvn-entrypoint.sh \
    && rm -rf /usr/local/setup_8.x && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/tini", "--", "/usr/local/bin/mvn-entrypoint.sh"]
CMD ["mvn"]