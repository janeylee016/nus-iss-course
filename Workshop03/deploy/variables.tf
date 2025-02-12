variable DO_token {
    type = string
    sensitive = true
    description = "DO token"
}

variable ssh_pub_key {
    type = string
    default = "workshop01_pub"
}

variable ssh_private_key {
    type = string
    default = "workshop01"
}

variable DO_size {
    type = string
    default = "s-1vcpu-2gb"
}

variable DO_region {
    type = string
    default = "sgp1"
}

variable code_server_password {
    type = string
    sensitive = true
}