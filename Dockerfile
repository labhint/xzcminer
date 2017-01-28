
FROM alpine:latest

MAINTAINER AnyBucket <anybucket@gmail.com>

RUN apk add --update --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ tini docker && \
    apk add --no-cache \
		ca-certificates \
		curl \
		openssl \
		libressl
		#libssl-dev

RUN set -x && \
		apk add --no-cache --virtual .build-deps \
	  autoconf \
	  automake \
	  libcurl \
	  libssl1.0 \
	  #libssl-dev \
	  pkgconf \
    pkgconfig \
    gmp \
	  build-base \
	  curl-dev \
	  #openssl \
	#openssl-dev \
    gcc \
		clang \
    jansson \
    jansson-dev \
    
    libtool \
    make \
		git



RUN git clone https://github.com/baseboxorg/cpuminer-xzc.git /cpuminer

WORKDIR /cpuminer

#RUN ./build.sh
RUN make clean || echo clean && \
    rm -f config.status
    
RUN ./autogen.sh || echo done && \
    ./configure CFLAGS="-O3 -march=native" --with-crypto --with-curl
 
RUN make
    
RUN apk del .build-deps

ENTRYPOINT [ "./cpuminer" ]

CMD ["--help"]


