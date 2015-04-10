# Use `terraform -var 'discovery_token=...'` to define it in runtime
variable "discovery_token" {}
variable "digitalocean_token" {}
variable "cloudflare_token" {}
variable "cloudflare_email" {}
variable "mackerel_apikey" {}

provider "cloudflare" {
  email = "${var.cloudflare_email}"
  token = "${var.cloudflare_token}"
}

resource "cloudflare_record" "www" {
  domain = "genkisugimoto.com"
  name = "www"
  # Use coreos-0 as an entry point
  value = "${digitalocean_droplet.coreos.0.ipv4_address}"
  type = "A"
  ttl = 1
}

resource "cloudflare_record" "root" {
  domain = "genkisugimoto.com"
  name = "genkisugimoto.com"
  # Use coreos-0 as an entry point
  value = "www.genkisugimoto.com"
  type = "CNAME"
  ttl = 1
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
  private_networking = true
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

  provisioner "file" {
    source = "containers/"
    destination = "/home/core"
    connection = {
      user = "core"
      key_file = "~/.ssh/id_rsa"
    }
  }

  provisioner "file" {
    source = "assets"
    destination = "/home/core"
    connection = {
      user = "core"
      key_file = "~/.ssh/id_rsa"
    }
  }

  # Preparations
  provisioner "remote-exec" {
    inline = [
      "cd /home/core",
      "cat assets/jpblog-wercker-deploy-key >> .ssh/authorized_keys",
      "cat assets/blog-wercker-deploy-key >> .ssh/authorized_keys",
      "chmod +x ./entry/script/start.sh",
      "chmod +x ./app/rproxy/script/start.sh",
      "chmod +x ./intra/intra-rproxy/script/start.sh"
    ]
    connection = {
      user = "core"
      key_file = "~/.ssh/id_rsa"
    }
  }

  # Install and run Mackerel
  provisioner "remote-exec" {
    inline = [
      "curl -O http://file.mackerel.io/agent/tgz/mackerel-agent-latest.tar.gz",
      "tar xzf mackerel-agent-latest.tar.gz",
      "sudo mkdir /etc/mackerel-agent",
      "echo 'apikey = \"${var.mackerel_apikey}\"' | sudo tee --append /etc/mackerel-agent/mackerel-agent.conf"
      # https://gist.github.com/kotaro-dev/b2c81b6e9775dc1e0256
      "nohup sudo systemd-run ./mackerel-agent/mackerel-agent &"
    ]
    connection = {
      user = "core"
      key_file = "~/.ssh/id_rsa"
    }
  }
}

output "entrypoint-ip" {
  value = "${digitalocean_droplet.coreos.0.ipv4_address}"
}
