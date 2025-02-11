# # data is something that we look up
data "digitalocean_ssh_key" "workshop01_pub" {
#   name = "workshop01"
    name = var.public_key #actual resource name in digital ocean
}

# resource "digitalocean_droplet" "droplet-day01" {
#     # using for each
#     for_each = var.droplets
#     name = each.key
#     image = each.value.image
#     size = each.value.size
#     region = each.value.region

#     # using var
#     # count = var.instance_count
#     # name = "droplet-day01-${count.index}"
#     # image = var.droplet_image
#     # size = var.droplet_size
#     # region = var.droplet_region
#     # ssh_keys = [data.digitalocean_ssh_key.nus-iss.fingerprint]
# }

resource "digitalocean_droplet" "droplet-day01" {
   # using var
    count = var.instance_count
    name = "droplet-day01-${count.index}"
    image = var.droplet_image
    size = var.droplet_size
    region = var.droplet_region
    ssh_keys = [data.digitalocean_ssh_key.workshop01_pub.fingerprint]

    connection {
        type = "ssh"
        user = "root"
        private_key = file(var.private_key)
        host = self.ipv4_address
    }

    provisioner "remote-exec" {
        inline = [
            "apt update",
            "apt upgrade -y",
            "useradd newfred"
        ]
    }
}

resource "local_file" "name" {
    filename = "droplets_ips.txt"
    content = templatefile("droplets_ips.txt.tftpl", {
        message = "Generated on Feb 10 2025"
        droplets_ips = [ for d in digitalocean_droplet.droplet-day01: d.ipv4_address]
        # droplets_ips = digitalocean_droplet.droplet-day01.ips(*).ipv4_address
    })
}

output "ssh_apic_fingerprint" {
    description = "This is the fingerprint of my public key"
    value = data.digitalocean_ssh_key.workshop01_pub.fingerprint
}

output "apic_certificate" {
    value = data.digitalocean_ssh_key.workshop01_pub.public_key
}

output "droplet-day01-ipv4" {
    description = "Droplet public IP address"
    value = join(", ", [ for d in digitalocean_droplet.droplet-day01: d.ipv4_address ]) # cannot put a * when using a map
}

# output "droplet-day01-ipv4" {
#     description = "Droplet public IP address"
#     value = join(", ", digitalocean_droplet.droplet-day01[*].ipv4_address) # * means for everything
# }

# output "droplet-day01-ipv4" {
#     description = "Droplet public IP address"
#     value = digitalocean_droplet.droplet-day01.ipv4_address
# }


# ===================================================================
# NOTES
# terraform init
# terraform plan
# terraform output
# terraform destroy (destroy the statefile)

# ssh -i opt/tmp/

# tf graph | dot -Tpng > graph.png (create a pic of dependencies)
# bat terraform.tfstate (to see whats in the tfstate)
# tf plan 

# to generate multiple copies (i.e. inbound rule), use dynamic inbound_rule 
# iterator; use to change the naming (i.e. dont like each, can change to rule)

# taint the resource -> means the resource mark as dirty
# when type apply, will destroy and recreate that resource only
# after tainting it and want to keep it, can untaint

# terraform import -> to add items that existed but not in the state 

# ssh -i ~/.ssh/workshop01 root@188.166.230.7 /206.189.158.127