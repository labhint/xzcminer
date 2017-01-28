
FROM alpine:latest
MAINTAINER AnyBucket <anybucket@gmail.com>

RUN apk add --update --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ tini docker

RUN apk add --no-cache \
		ca-certificates \
		curl \
		libressl

RUN set -x && \
		apk add --no-cache --virtual .build-deps \
	  autoconf \
	  automake \
    pkgconfig \
    gmp \
	  build-base \
	  curl-dev \
    gcc \
		clang \
    jansson \
    libtool \
    make \
		git
		
RUN git clone https://github.com/baseboxorg/cpuminer-xzc.git /usr/src/cpuminer && \
		cd /usr/src/cpuminer && \
		./build.sh
			
RUN rm -rf /usr/src/cpuminer && \
		apk del .build-deps

ENTRYPOINT [ "cpuminer" ]

CMD ["--help"]
