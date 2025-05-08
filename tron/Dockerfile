FROM eclipse-temurin:8-jre-alpine
ARG TRON_VERSION_TAG


COPY docker-entrypoint.sh /usr/local/bin/
COPY mainnet_net_config.conf /mainnet_net_config.conf

RUN apk add --no-cache aria2 curl && curl -L -o /FullNode.jar https://github.com/tronprotocol/java-tron/releases/download/${TRON_VERSION_TAG}/FullNode.jar;

ENTRYPOINT [ "docker-entrypoint.sh" ]
