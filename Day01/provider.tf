terraform {
    required_version = ">=1.10.0"
    required_providers {
        #setup the docker provider (for every one of these, need to set up the block)
        docker = {
            source  = "kreuzwerker/docker"
            version = "3.0.2"
        }
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

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

provider "local" {
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.DO_key
}

# link: https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs
# inside the directory, do "terraform init"
# anytime i change the provider files, i.e. add or change the version, need to run terraform init again 
# .terraform file has all the binaries, need to git ignore the files
# lock file is so that if got new versions, won't download the new versions. If want to dl, just delete the lock file.