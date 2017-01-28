FROM baseboxorg/ubuntu-advance:16.04

MAINTAINER Anybucket

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -qq install \
    curl libssl-dev automake autoconf pkg-config libcurl4-openssl-dev libjansson-dev libgmp-dev git make

RUN git clone https://github.com/baseboxorg/cpuminer-xzc.git /cpuminer && \
    cd /cpuminer && \
    ./build.sh
    
WORKDIR /cpuminer 

RUN cp cpuminer /usr/local/bin/cpuminer && chmod a+x /usr/local/bin/*
    
RUN apt-get remove -y automake autoconf pkg-config git make libcurl4-openssl-dev libjansson-dev libgmp-dev && \
     apt-get autoremove -y && \
     rm -rf /var/lib/apt/lists/* && \
     rm -rf /cpuminer



# Metadata params
ARG BUILD_DATE
ARG VERSION
ARG VCS_URL
ARG VCS_REF
# Metadata
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="cpuminer-xzc" \
      org.label-schema.description="Running cpuminer-xzc in docker container" \
      org.label-schema.url="https://zcoin.tech/" \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vendor="AnyBucket" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0" \
      com.microscaling.docker.dockerfile="/Dockerfile"
      
      
ENTRYPOINT	["cpuminer"]

CMD ["--help"]
