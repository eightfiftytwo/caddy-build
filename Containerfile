# Build stage
ARG CADDY_VERSION=2
FROM docker.io/library/caddy:${CADDY_VERSION}-builder AS builder

# Build Caddy with the Hetzner DNS module
RUN xcaddy build \
  --with github.com/caddy-dns/hetzner/v2 \
  --with github.com/mholt/caddy-l4/modules/l4proxy \
  --with github.com/mholt/caddy-l4/modules/l4tls \
  --with github.com/mholt/caddy-l4/modules/l4proxyprotocol

# Final stage
FROM docker.io/library/caddy:${CADDY_VERSION}

# Copy the custom-built Caddy binary
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
