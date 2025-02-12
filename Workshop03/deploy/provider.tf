terraform {
    required_version = ">=1.10.0"
    required_providers {
        #setup the docker provider (for every one of these, need to set up the block)
        local = {
            source = "hashicorp/local"
            version = "2.5.2"
        }
        digitalocean = {
            source = "digitalocean/digitalocean"
            version = "2.48.2"
        }
    }
}

provider "local" {
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.DO_token
}
