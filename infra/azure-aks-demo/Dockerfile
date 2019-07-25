FROM openjdk:12-alpine
MAINTAINER twecker

## Proxy variables are docker default
#ARG HTTP_PROXY
#ARG HTTPS_PROXY

ENV HTTP_PROXY ${HTTP_PROXY}
ENV HTTPS_PROXY ${HTTPS_PROXY}

RUN mkdir -p /vol1/{app,config}

COPY azure-aks-demo-*.jar /vol1/app/

# Install shadow for usermod
RUN apk --no-cache add shadow

RUN groupadd -r -f cg-app-jvm -g 22000 && \
    useradd -u 22000 -r -g cg-app-jvm -m -d /home/cg-app-jvm \
      -s /bin/false -c "jvm container user for demo" cu-app-jvm

RUN chown -R cu-app-jvm:cg-app-jvm /vol1

USER cu-app-jvm
WORKDIR /vol1/app/