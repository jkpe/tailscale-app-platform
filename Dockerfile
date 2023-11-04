FROM golang:1.21-alpine as builder
WORKDIR /app
COPY . ./
RUN go build -mod=vendor -o bin/hello

# https://docs.docker.com/develop/develop-images/multistage-build/#use-multi-stage-builds
FROM alpine:latest
RUN apk update && apk add ca-certificates iptables ip6tables && rm -rf /var/cache/apk/*

# Copy binary to production image.
COPY --from=builder /app/start.sh /app/start.sh

# https://github.com/digitalocean/sample-dockerfile/blob/main/Dockerfile
COPY --from=builder /app/bin/hello /usr/local/bin/

# Copy Tailscale binaries from the tailscale image on Docker Hub.
COPY --from=docker.io/tailscale/tailscale:stable /usr/local/bin/tailscaled /app/tailscaled
COPY --from=docker.io/tailscale/tailscale:stable /usr/local/bin/tailscale /app/tailscale
RUN mkdir -p /var/run/tailscale /var/cache/tailscale /var/lib/tailscale

RUN ["chmod", "+x", "/app/start.sh"]

# Run on container startup.
CMD ["/app/start.sh"]
