#!/bin/sh

/app/tailscaled --tun=userspace-networking --socks5-server=localhost:1055 &
/app/tailscale up --authkey=${TAILSCALE_AUTHKEY} --hostname=do-app-platform
echo Tailscale started
ALL_PROXY=socks5://localhost:1055/ /usr/local/bin/hello
