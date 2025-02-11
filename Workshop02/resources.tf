# create SSH public key on local
# shh-key - t ed25519 -f workshop01
data "digitalocean_ssh_key" "workshop01_pub" {
    name = "workshop01_pub"
}

# Provision a droplet on sgp1, 1 Gb memory, 2 vcpu, ubuntu 24.04
resource "digitalocean_droplet" "droplet-ws-02" {
    name    = "droplet-ws-02"
    image   = var.droplet_image
    region  = var .droplet_region
    size    = var.droplet_size
    ssh_keys = [data.digitalocean_ssh_key.workshop01_pub.id] # to upload the public ssh key
}

resource "local_file" "inventory-yaml" {
    filename = "inventory.yaml"
    content = templatefile("inventory.yaml.tftpl", {
        private_key_path = var.private_key
        droplet_id = digitalocean_droplet.droplet-ws-02.ipv4_address
    })
    file_permission = "0444"
}

# create a local file with the name nginx-<ip addr>.nip.io
resource "local_file" "root_at_id" {
    filename = "root@${digitalocean_droplet.droplet-ws-02.ipv4_address}"
    content = ""
    file_permission = "0444"
}

output "droplet_ip" {
    value = digitalocean_droplet.droplet-ws-02.ipv4_address
}

