# create SSH public key on local
# shh-key - t ed25519 -f workshop01
resource "digitalocean_ssh_key" "workshop01_pub" {
    name = "workshop01_pub"
    public_key = file(var.public_key)
}

# 1. Provision a droplet on sgp1, 1 Gb memory, 1 vcpu, ubuntu 24.04
# Create a new Web Droplet in the sgp1 region
resource "digitalocean_droplet" "droplet-ws-01" {
    name    = "droplet-ws-01"
    image   = var.droplet_image
    region  = var .droplet_region
    size    = var.droplet_size
    ssh_keys = [digitalocean_ssh_key.workshop01_pub.id] # to upload the public ssh key

    connection {
        type = "ssh"
        user = "root"
        private_key = file(var.private_key)
        host = self.ipv4_address
    }

    # 2. install nginx
    provisioner "remote-exec" {
        inline = [
            "apt update",
            "apt upgrade -y",
            "apt install -y nginx",
            "systemctl start nginx",
            "systemctl enable nginx",
        ]
    }

    provisioner "file" {
        source = "assets/"
        destination = "/var/www/html"
    }
    
}

resource "local_file" "index_html" {
    filename = "assets/index.html"
    file_permission = "0644"
    content = templatefile("assets/index.html.tftpl", {
        message = "Generated on Feb 10 2025"
        droplet_id = digitalocean_droplet.droplet-ws-01.ipv4_address
    })
}

# 4. create a local file with the name nginx-<ip addr>.nip.io
resource "local_file" "nginx_dns" {
    filename = "nginx-${digitalocean_droplet.droplet-ws-01.ipv4_address}.nip.io"
    content = ""
    file_permission = "0444"
}


# output the fingerprint
output ssh_fingerprint {
    value = digitalocean_ssh_key.workshop01_pub.fingerprint
}

output "nginx_ip" {
    value = digitalocean_droplet.droplet-ws-01.ipv4_address
}
