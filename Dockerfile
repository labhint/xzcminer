FROM resin/armv7hf-debian

MAINTAINER Anybucket

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -qq install \
    curl clang libssl-dev automake autoconf pkg-config libcurl4-openssl-dev libjansson-dev libgmp-dev git make 

RUN git clone https://github.com/baseboxorg/cpuminer-xzc.git /cpuminer && \
    cd /cpuminer && \
    git checkout rpi2 && \
    ./autogen.sh && \
    ./configure CFLAGS="-march=native" --with-crypto --with-curl && \
    make
    
RUN mv /cpuminer/cpuminer /usr/local/bin/cpuminer && chmod a+x /usr/local/bin/cpuminer
    
RUN apt-get remove -y automake autoconf libssl-dev pkg-config git make && \
     apt-get autoremove -y && \
     rm -rf /var/lib/apt/lists/* && \
     rm -rf /cpuminer
      
ENTRYPOINT	["/usr/local/bin/cpuminer"]

CMD ["--help"]
