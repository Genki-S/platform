# Use `terraform -var 'discovery_token=...'` to define it in runtime
variable "discovery_token" {}
variable "digitalocean_token" {}
variable "cloudflare_token" {}
variable "cloudflare_email" {}

provider "cloudflare" {
  email = "${var.cloudflare_email}"
  token = "${var.cloudflare_token}"
}

resource "cloudflare_record" "genkisugimoto" {
  domain = "genkisugimoto.com"
  name = "genkisugimoto"
  # Use coreos-0 as an entry point
  value = "${digitalocean_droplet.coreos.0.id}"
  type = "A"
}

provider "digitalocean" {
  token = "${var.digitalocean_token}"
}

resource "digitalocean_droplet" "coreos" {
  count = 3
  image = "coreos-stable"
  name = "coreos-${count.index}"
  region = "sgp1"
  size = "512mb"
  # Run `tagboat keys` to find your key id
  ssh_keys = [496296]
  user_data = <<EOS
#cloud-config

coreos:
  etcd:
    discovery: https://discovery.etcd.io/${var.discovery_token}
    addr: $private_ipv4:4001
    peer-addr: $private_ipv4:7001
  fleet:
    public-ip: $private_ipv4
    metadata: name=coreos-${count.index}
  units:
    - name: etcd.service
      command: start
    - name: fleet.service
      command: start
EOS
}
