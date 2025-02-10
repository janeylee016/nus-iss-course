variable "DO_key" {
    type = string 
    description = "DO key"
    default = "set this"
    sensitive = "true" # terraform will not log it out
}

variable "public_key" {
    type = string
    description = "public_key"
    default = "workshop01_pub"
}

variable "instance_count" {
    type = number
    default = 2
}

variable droplet_size {
    type = string
    default = "s-1vcpu-1gb"
}

variable droplet_image {
    type = string
    default = "ubuntu-24-04-x64"
}

variable droplet_region {
    type = string
    default = "sgp1"
}

variable droplets {
    type = map(
        object ({
            size = string
            image = string
            region = string
        })
    )
    default = {
        myserver-1gb = {
            size = "s-1vcpu-1gb"
            image = "ubuntu-22-04-x64"
            region = "sgp1"
        },
        myserver-512mb = {
            size = "s-1vcpu-512mb-10gb"
            image = "ubuntu-24-10-x64"
            region = "sgp1"
        }
    }
}

variable "private_key" {
    type = string
    sensitive = true
}

#digital ocean api slugs