FROM baseboxorg/ubuntu-advance:16.04

MAINTAINER Anybucket

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -qq install \
    curl libssl-dev automake autoconf pkg-config libcurl4-openssl-dev libjansson-dev libgmp-dev git make

RUN git clone https://github.com/baseboxorg/cpuminer-xzc.git /cpuminer && \
    cd /cpuminer && \
    ./build.sh && \
    mv /cpuminer/cpuminer /usr/local/bin/cpuminer && \
    chmod a+x /usr/local/bin/cpuminer
    
RUN apt-get remove -y automake autoconf libssl-dev pkg-config git make && \
     apt-get autoremove -y && \
     rm -rf /var/lib/apt/lists/* && \
     rm -rf /cpuminer
      
ENTRYPOINT	["/usr/local/bin/cpuminer"]

CMD ["--help"]
