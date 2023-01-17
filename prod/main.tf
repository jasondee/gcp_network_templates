terraform {
    required_version = ">= 1.0.11"
    required_providers {
        google = {
            source = "hashicorp/google"
            version = ">= 4.5.0"
        }
    }
}

module "network" {
    source = "../modules/networking
    environment = "prod"
    cidr_range = 10.10.0.0/8
    regions ["us-east4", "us-central1", "us-west1", "us-east1"]
    subnet_size = 24
}