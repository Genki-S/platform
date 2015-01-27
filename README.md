# Platform

## Prerequisites

- All files under `container` must reside on all hosts' `/home/core` directories

## TODO

- Get rid of prerequisites
- Create entry point
  - Fixed IP or Dynamic DNS?
- Recovery strategy
  - [Dead container not restarted with Restart=always in Service · Issue #940 · coreos/fleet](https://github.com/coreos/fleet/issues/940)
- `\*-docker-reg.service` files are redundant. Combine with [progrium/registrator](https://registry.hub.docker.com/u/progrium/registrator/)
  - `\*-dynamic-amb.service` files might be also combined using [progrium/ambassadord](https://registry.hub.docker.com/u/progrium/ambassadord/)

## Architecture

TODO

## Resources

### Ambassador pattern

- [Automated docker ambassadors with CoreOS + registrator + ambassadord « Random thoughts along the roadside…](http://www.virtualroadside.com/blog/index.php/2014/07/28/automated-docker-ambassadors-with-coreos-registrator-ambassadord/)
- [Dynamic Docker links with an ambassador powered by etcd](https://coreos.com/blog/docker-dynamic-ambassador-powered-by-etcd/)
- [How To Use the Ambassador Pattern to Dynamically Configure Services on CoreOS | DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-use-the-ambassador-pattern-to-dynamically-configure-services-on-coreos)

### DNS approach

Dynamic DNS can be used instead of ambassador pattern.

- [SkyDNS (Or The Long Road to Skynet)](http://blog.gopheracademy.com/skydns/)

### General Service Discovery

- [Understanding Modern Service Discovery with Docker :: Jeff Lindsay](http://progrium.com/blog/2014/07/29/understanding-modern-service-discovery-with-docker/)
- [Consul Service Discovery with Docker :: Jeff Lindsay](http://progrium.com/blog/2014/08/20/consul-service-discovery-with-docker/)
- [Automatic Docker Service Announcement with Registrator :: Jeff Lindsay](http://progrium.com/blog/2014/09/10/automatic-docker-service-announcement-with-registrator/)

### Troubleshooting

- [How To Troubleshoot Common Issues with your CoreOS Servers | DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-troubleshoot-common-issues-with-your-coreos-servers)
- [fleetctl memory address errors with status, ssh, and journal commands · Issue #139 · coreos/fleet](https://github.com/coreos/fleet/issues/139)
