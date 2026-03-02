# dnsmasq-alpine

Simple dnsmasq container, based on Alpine.

## Run with `docker compose`
`docker-compose.yml`
```yml
services:
  dnsmasq:
    image: ghcr.io/walterpinkman/dnsmasq-alpine:latest
    container_name: dnsmasq
    volumes:
      - ./dnsmasq.d:/etc/dnsmasq.d:ro
    read_only: true
    cap_drop:
      - ALL
    security_opt:
      - no-new-privileges:true
    ports:
      - 10.10.10.11:1053:1053/udp
      - 10.10.10.11:1053:1053/tcp
    restart: unless-stopped
```

## `dnsmasq` config
`dnsmasq.d/config.conf`
```bash
# Don't read /etc/resolv.conf. Get upstream servers only from the configuration
no-resolv

# DNS port to be used
port=1053

# Listen on one interface
interface=eth0

# List of upstream DNS server
server=9.9.9.9
server=1.1.1.1

# Local DNS entries
addn-hosts=/etc/dnsmasq.d/hosts

# Set the size of dnsmasq's cache. The default is 150 names. Setting the cache
# size to zero disables caching. Note: huge cache size impacts performance
cache-size=10000

# Return answers to DNS queries from /etc/hosts and interface-name and
# dynamic-host which depend on the interface over which the query was
# received. If a name has more than one address associated with it, and
# at least one of those addresses is on the same subnet as the interface
# to which the query was sent, then return only the address(es) on that
# subnet and return all the available addresses otherwise.
localise-queries

# Bogus private reverse lookups. All reverse lookups for private IP
# ranges (ie 192.168.x.x, etc) which are not found in /etc/hosts or the
# DHCP leases file are answered with NXDOMAIN rather than being forwarded
bogus-priv

# Use stale cache entries for a given number of seconds to optimize cache utilization
# Setting the time to zero will serve stale cache data regardless how long it has expired.
use-stale-cache=3600

# Do not forward .home.arpa and .internal domains to upstream servers
local=/home.arpa/
local=/internal/

```
`dnsmasq.d/hosts`
```
10.10.10.11 service1.domain.tld
10.10.10.11 service1.domain.tld
```
