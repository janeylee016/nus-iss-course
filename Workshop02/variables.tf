variable droplet_size {
    type = string
    default = "s-1vcpu-2gb"
}

variable droplet_image {
    type = string
    default = "ubuntu-24-04-x64"
}

variable droplet_region {
    type = string
    default = "sgp1"
}

variable DO_key {
    type = string
    description = "DO key"
    default = "set this"
    sensitive = "true" # terraform will not log it out
}

variable "private_key" {
    type = string
    sensitive = true
}

variable "public_key" {
    type = string
    description = "public_key"
    default = "workshop01.pub"
}