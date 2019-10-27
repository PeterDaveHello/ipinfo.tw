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

## Usage

```sh
docker run -d --name ipinfo.tw -p 80:80 peterdavehello/ipinfo.tw:latest
```

## License

This project is released under the GPL-3.0 license. It uses GeoLite2 data created by [MaxMind][3].

[1]:https://en.wikipedia.org/wiki/Autonomous_system_(Internet)
[2]:https://en.wikipedia.org/wiki/User_agent
[3]:https://www.maxmind.com
