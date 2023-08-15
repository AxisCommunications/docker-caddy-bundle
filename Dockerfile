FROM caddy:2.7.3-builder AS builder

RUN xcaddy build \
    --with github.com/greenpau/caddy-security@v1.1.18

FROM caddy:2.7.3

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
