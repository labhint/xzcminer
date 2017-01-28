
FROM alpine:latest

MAINTAINER AnyBucket <anybucket@gmail.com>

RUN apk add --update --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ tini docker && \
    apk add --no-cache \
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



RUN git clone https://github.com/baseboxorg/cpuminer-xzc.git /cpuminer

WORKDIR /cpuminer

RUN cd /cpuminer && \
    ./build.sh && \
    apk del .build-deps

ENTRYPOINT [ "./cpuminer" ]

CMD ["--help"]
