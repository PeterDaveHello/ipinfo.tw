# ipinfo.tw

![license](https://img.shields.io/badge/license-GPLv3.0-brightgreen.svg?style=flat)
[![Build Status](https://travis-ci.com/PeterDaveHello/ipinfo.tw.svg?branch=master)](https://travis-ci.com/PeterDaveHello/ipinfo.tw)
[![Docker Hub pulls](https://img.shields.io/docker/pulls/peterdavehello/ipinfo.tw.svg)](https://hub.docker.com/r/peterdavehello/ipinfo.tw/)
[![Docker image layers](https://images.microbadger.com/badges/image/peterdavehello/ipinfo.tw.svg)](https://microbadger.com/images/peterdavehello/ipinfo.tw/)
[![Docker image version](https://images.microbadger.com/badges/version/peterdavehello/ipinfo.tw.svg)](https://hub.docker.com/r/peterdavehello/ipinfo.tw/tags/)

[![Docker Hub badge](http://dockeri.co/image/peterdavehello/ipinfo.tw)](https://hub.docker.com/r/peterdavehello/ipinfo.tw/)

A self-hosted, non-tracking, and ad-free solution to reveal client-side IP info like IP address, conuntry, [AS][1] number/description, and additionally, [user agent][2].

## This is DigitalOcean App Platform Branch

Due to the Cloudflare CDN is not able to be disabled on DigitalOcean App Platform right now, this branch is created as a workaround to use the HTTP header `DO-Connecting-IP` as the client's IP

See the [master branch](https://github.com/PeterDaveHello/ipinfo.tw/tree/master) for more up-to-date info.

[![Deploy to DO](https://mp-assets1.sfo2.digitaloceanspaces.com/deploy-to-do/do-btn-blue.svg)](https://cloud.digitalocean.com/apps/new?repo=https://github.com/PeterDaveHello/ipinfo.tw/tree/DigitalOceanAppPlatform&refcode=1fdd0a1d695a)

## License

This project is released under the GPL-3.0 license. It uses GeoLite2 data created by [MaxMind][3].

[1]:https://en.wikipedia.org/wiki/Autonomous_system_(Internet)
[2]:https://en.wikipedia.org/wiki/User_agent
[3]:https://www.maxmind.com
