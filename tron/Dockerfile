FROM eclipse-temurin:8-jre-noble
ARG TRON_VERSION_TAG


COPY docker-entrypoint.sh /usr/local/bin/
COPY main_net_config.conf /main_net_config.conf
COPY log-stdout.xml /log-stdout.xml

RUN apt update && apt install -y aria2 curl && apt clean && curl -L -o /FullNode.jar https://github.com/tronprotocol/java-tron/releases/download/${TRON_VERSION_TAG}/FullNode.jar;

ENTRYPOINT [ "docker-entrypoint.sh" ]
