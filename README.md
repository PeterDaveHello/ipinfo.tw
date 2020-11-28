# ipinfo.tw

![license](https://img.shields.io/badge/license-GPLv3.0-brightgreen.svg?style=flat)
[![Build Status](https://travis-ci.com/PeterDaveHello/ipinfo.tw.svg?branch=master)](https://travis-ci.com/PeterDaveHello/ipinfo.tw)
[![Docker Hub pulls](https://img.shields.io/docker/pulls/peterdavehello/ipinfo.tw.svg)](https://hub.docker.com/r/peterdavehello/ipinfo.tw/)
[![Docker image layers](https://images.microbadger.com/badges/image/peterdavehello/ipinfo.tw.svg)](https://microbadger.com/images/peterdavehello/ipinfo.tw/)
[![Docker image version](https://images.microbadger.com/badges/version/peterdavehello/ipinfo.tw.svg)](https://hub.docker.com/r/peterdavehello/ipinfo.tw/tags/)

[![Docker Hub badge](http://dockeri.co/image/peterdavehello/ipinfo.tw)](https://hub.docker.com/r/peterdavehello/ipinfo.tw/)

A self-hosted, non-tracking, and ad-free solution to reveal client-side IP info like IP address, conuntry, [AS][1] number/description, and additionally, [user agent][2].

## Demo

This project is also hosted publicly on https://ipinfo.tw, feel free to give it a try!

Please note that for privacy concerns, this demo is behind an reverse proxy with https enabled, which is not part of this project. http traffic will be redirected to use https to establish the connection, in case the plaintext data being snifferred/intercepted.

## Usage

### Server side

Run the server daemon via docker:

```sh
docker run -d --name ipinfo.tw -p 80:80 peterdavehello/ipinfo.tw:latest
```

If you want to put this container behind reverse proxy, set up an `X-Real-IP` header and pass the it to the container, so that it can use the header as the IP of the client.

### Client side

Use any http(s) client to explore the server, e.g. https://ipinfo.tw,

- `wget -qO- https://ipinfo.tw`
- `curl https://ipinfo.tw`

Without any specified URI, the server will return IP address, country, AS, and user agent.

If you prefer to receive a machine-readable result, use path `/json`, e.g. `https://ipinfo.tw/json`, the result will look like:

```json
{"ip":"3.115.123.234","country_code":"JP","country_name":"Japan","asn":"16509","as_desc":"Amazon.com, Inc.","user_agent":"curl/7.58.0"}
```

You can also specify the following URI to retrieve certain info:

- `ip`: IP address
- `country`: Country code and name
- `country_code`: Country code
- `country_name`: Country name
- `as`: AS number and description
- `asn`: AS number
- `as_desc`: AS description
- `user_agent`: User agent string

Examples:

```sh
$ wget -qO- https://ipinfo.tw
157.230.195.167
SG / Singapore
AS14061 / DigitalOcean, LLC
Wget/1.17.1 (linux-gnu)

$ curl https://ipinfo.tw/ip
18.179.200.1

$ curl https://ipinfo.tw/country
TW / Taiwan

$ curl https://ipinfo.tw/country_code
HK

$ curl https://ipinfo.tw/country_name
South Korea

$ curl https://ipinfo.tw/as
AS16509 / Amazon.com, Inc.

$ curl https://ipinfo.tw/as
AS8075 / Microsoft Corporation

$ curl https://ipinfo.tw/asn
15169

$ curl https://ipinfo.tw/as_desc
Google LLC

$ wget -qO- https://ipinfo.tw/user_agent
Wget
```

As mentioned above, if `https://` is not specified, connection will be redirected from http to https, in this case, `curl` will need an additional parameter: `-L`/`--location` to follow location redirection.

## Build

If you want to build your own image, instead of directly pull the pre-built one, clone this repository, and run `docker build` command, with build-arg `MAXMIND_LICENSE_KEY`, you need to provide your own MaxMind license key from https://www.maxmind.com/en/account, it's **free**.

```sh
$ git clone --depth 1 https://github.com/PeterDaveHello/ipinfo.tw
$ cd ipinfo.tw
$ docker build --build-arg MAXMIND_LICENSE_KEY="$MY_MAXMIND_KEY" -t ipinfo.tw:custom-build .
```

## License

This project is released under the GPL-3.0 license. It uses GeoLite2 data created by [MaxMind][3].

[1]:https://en.wikipedia.org/wiki/Autonomous_system_(Internet)
[2]:https://en.wikipedia.org/wiki/User_agent
[3]:https://www.maxmind.com
