FROM ubuntu

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -qq install \
    automake autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev clang git make nano screen && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/dockerhint/cpuminer-xzc.git /cpuminer && \
    cd /cpuminer && \
    ./build.sh

WORKDIR /cpuminer

# Metadata params
ARG BUILD_DATE
ARG VERSION
ARG VCS_URL
ARG VCS_REF
# Metadata
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="cpuminer-xzc" \
      org.label-schema.description="Running cpuminer-xzc in docker container" \
      org.label-schema.url="https://xzc.org/" \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vendor="AnyBucket" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0" \
      com.microscaling.docker.dockerfile="/Dockerfile"
      
      
ENTRYPOINT	["./cpuminer"]

CMD ["--help"]
