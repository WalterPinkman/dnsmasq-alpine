FROM alpine:latest

EXPOSE 1053/udp
EXPOSE 1053/tcp

RUN apk add --no-cache dnsmasq

USER dnsmasq

ENTRYPOINT ["dnsmasq", "--keep-in-foreground", "--conf-file=/etc/dnsmasq.conf"]
