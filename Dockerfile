FROM alpine:3.11 as prepare

ARG MAXMIND_LICENSE_KEY

RUN mkdir /GeoLite2/
WORKDIR /GeoLite2/

ENV MAXMIND_BASE_URL "https://download.maxmind.com/app/geoip_download?license_key=$MAXMIND_LICENSE_KEY&"

RUN wget "${MAXMIND_BASE_URL}edition_id=GeoLite2-ASN&suffix=tar.gz" -O GeoLite2-ASN.tar.gz
RUN wget "${MAXMIND_BASE_URL}edition_id=GeoLite2-ASN&suffix=tar.gz.sha256" -O GeoLite2-ASN.tar.gz.sha256
RUN sed 's/GeoLite2-ASN_[0-9]*.tar.gz/GeoLite2-ASN.tar.gz/g' -i GeoLite2-ASN.tar.gz.sha256
RUN sha256sum -c GeoLite2-ASN.tar.gz.sha256
RUN tar xvf GeoLite2-ASN.tar.gz --strip 1

RUN wget "${MAXMIND_BASE_URL}edition_id=GeoLite2-Country&suffix=tar.gz" -O GeoLite2-Country.tar.gz
RUN wget "${MAXMIND_BASE_URL}edition_id=GeoLite2-Country&suffix=tar.gz.sha256" -O GeoLite2-Country.tar.gz.sha256
RUN sed 's/GeoLite2-Country_[0-9]*.tar.gz/GeoLite2-Country.tar.gz/g' -i GeoLite2-Country.tar.gz.sha256
RUN sha256sum -c GeoLite2-Country.tar.gz.sha256
RUN tar xvf GeoLite2-Country.tar.gz --strip 1

FROM alpine:3.11 as release
LABEL name="ipinfo.tw"
RUN mkdir -p /run/nginx/ /usr/share/GeoIP/
COPY --from=prepare /GeoLite2/*.mmdb /usr/share/GeoIP/

# hadolint ignore=DL3018
RUN apk add --no-cache nginx nginx-mod-http-geoip2

COPY nginx.conf  /etc/nginx/
COPY ipinfo.conf /etc/nginx/conf.d/default.conf

RUN nginx -t 1>&2

HEALTHCHECK --timeout=10s --start-period=5s CMD wget -O /dev/null http://127.0.0.1 || exit 1

EXPOSE 80

ENTRYPOINT [ "/usr/sbin/nginx", "-g", "daemon off;" ]
