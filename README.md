# tailscale-app-platform
Tailscale on DigitalOcean App Platform

enviromental variable TAILSCALE_AUTHKEY needs to be set

see: https://tailscale.com/kb/1108/cloudrun/?q=go%20run

issues to address:

```
root@tailscale-vm-lon1:~# tailscale ping 100.118.95.97
pong from do-app-platform-1 (100.118.95.97) via DERP(waw) in 115ms
pong from do-app-platform-1 (100.118.95.97) via DERP(waw) in 53ms
```

derp is waw? Why not london? VM and App is in London
