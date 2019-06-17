FROM openjdk:8-jre

ENV MANIFOLDCF_VERSION 2.13
ENV CIFS_VERSION 1.3.19

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes --no-install-recommends \
    wget curl ca-certificates \
    gzip && \
  	rm -rf /var/lib/apt/lists/*

RUN wget http://apache.mirror.rafal.ca/manifoldcf/apache-manifoldcf-${MANIFOLDCF_VERSION}/apache-manifoldcf-${MANIFOLDCF_VERSION}-bin.tar.gz && \
    wget https://jcifs.samba.org/src/jcifs-${CIFS_VERSION}.jar && \
    tar -xzvf apache-manifoldcf-${MANIFOLDCF_VERSION}-bin.tar.gz && \
    cp -R apache-manifoldcf-${MANIFOLDCF_VERSION} /usr/share/manifoldcf && \
    cp jcifs-${CIFS_VERSION}.jar /usr/share/manifoldcf/connector-lib-proprietary

EXPOSE 8345

WORKDIR /usr/share/manifoldcf/example

VOLUME /var/manifoldcf

COPY properties.xml /usr/share/manifoldcf/example/properties.xml

# COPY start-options.env.unix /usr/share/manifoldcf/example/start-options.env.unix
# COPY connectors.xml /usr/share/manifoldcf/connectors.xml

CMD ["java", "-jar", "start.jar"]
