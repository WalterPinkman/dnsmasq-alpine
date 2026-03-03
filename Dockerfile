FROM alpine:latest

RUN apk add --no-cache dnsmasq

USER dnsmasq

ENTRYPOINT ["dnsmasq", "--keep-in-foreground", "--conf-file=/etc/dnsmasq.conf"]
