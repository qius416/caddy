FROM alpine:latest
MAINTAINER qius416 <qius416@gmail.com>

LABEL Description="Caddy Server With Some Convenient settings"

RUN apk add --update openssh-client git tar

RUN curl --silent --show-error --fail --location \
      --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
      "https://caddyserver.com/download/build?os=linux&arch=amd64&features=cors,git,hugo,ipfilter,mailout,prometheus,search,upload" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy \
 && chmod 0755 /usr/bin/caddy \
 && /usr/bin/caddy -version


RUN mkdir /cert && openssl genrsa -des3 -passout pass:xyz -out /cert/server.pass.key 2048 \
 && openssl rsa -passin pass:xyz -in /cert/server.pass.key -out /cert/server.key \
 && rm /cert/server.pass.key \
 && openssl req -new -key /cert/server.key -out /cert/server.csr \
  -subj "/C=JP/ST=Saitama/L=Toda/O=Hypocrisy/OU=IT Department/CN=qiushi.pro" \
 && openssl x509 -req -days 365 -in /cert/server.csr -signkey /cert/server.key -out /cert/server.crt

EXPOSE 80 443 2015
VOLUME /srv /conf /log
WORKDIR /srv

ENTRYPOINT ["/usr/bin/caddy"]
CMD ["--conf", "/conf/Caddyfile"]
