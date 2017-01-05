FROM alpine:3.4

# Add proxy modules
RUN apk add --no-cache apache2 apache2-proxy apache2-utils

# Add mod_xsendfile
RUN apk add --no-cache --virtual build-deps apache2-dev g++ openssl \
    && wget https://tn123.org/mod_xsendfile/mod_xsendfile.c \
    && apxs -ci mod_xsendfile.c \
    && apk del build-deps

COPY ./conf.d /etc/apache2/conf.d

RUN mkdir /run/apache2

CMD rm -rf /run/apache2/* && httpd -D FOREGROUND
