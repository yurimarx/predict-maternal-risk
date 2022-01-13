
ARG IMAGE=intersystemsdc/iris-ml-community:2021.2.0.617.0-zpm
FROM $IMAGE
LABEL maintainer="Yuri Gomes <yurimarx@gmail.com>"

USER root
WORKDIR /opt/irisapp
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisapp

USER ${ISC_PACKAGE_MGRUSER}

# copy files
COPY  Installer.cls .
COPY  automl.sql .
COPY src src
COPY  module.xml .  
COPY iris.script /tmp/iris.script

# run iris and script
RUN iris start IRIS \
	&& iris session IRIS < /tmp/iris.script \
    && iris stop IRIS quietly
