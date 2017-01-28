
FROM alpine:latest

MAINTAINER AnyBucket <anybucket@gmail.com>

RUN apk add --update --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ tini docker && \
    apk add --no-cache \
		ca-certificates \
		curl-dev \
		#openssl \
		libressl \
		#libressl2.4-libssl \
		#libssl1.0 \
		#openssl-dev \
		jansson-dev \
		gmp-dev
		

RUN set -x && \
		apk add --no-cache --virtual .build-deps \
	  autoconf \
	  automake \
	  #libcurl \
	  #libssl1.0 \
	  #libssl-dev \
	  #pkgconf \
    	pkgconfig \	
	autoconf \
	automake \
		build-base \
		#curl-dev \
	  #openssl \
	
		#clang \
    #jansson \
    
  
    #libtool \
    make \
		git



RUN git clone https://github.com/baseboxorg/cpuminer-xzc.git /cpuminer

WORKDIR /cpuminer

#RUN ./build.sh
RUN make clean || echo clean && \
    rm -f config.status
    
RUN export OBJECT_MODE=64 && \
    ./autogen.sh || echo done && \
    ./configure CFLAGS="-march=native" --with-crypto --with-curl
 
RUN make
    
RUN apk del .build-deps

ENTRYPOINT [ "./cpuminer" ]

CMD ["--help"]


