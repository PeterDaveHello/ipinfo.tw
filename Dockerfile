FROM peterdavehello/ipinfo.tw:latest

RUN sed -i 's/X-Real-IP/DO-Connecting-IP/g' /etc/nginx/conf.d/realip.conf
