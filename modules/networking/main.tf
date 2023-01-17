variable "environment" {
    description = "The stage of workloads that will be deployed to this network"
}

variable "cidr_range" {
    description = "The range of IP addresses for this VPC"
}

variable "regions" {
    type = list(string)
    description = "The regiones where the subnets will be created"
}

variabe "subnet_size" {
    type = number
}

locals {
    split_cidr = split("/", var.cidr_range)
    cidr_size  = element(local.split_cidr, length(local.split_cidr) -1)
    newbits    = var.subnet_size - tonumber(local.cidr_size)
}

resource "google_compute_network" "vpc" {
    name                    = "${var.environment}-vpc"
    auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
    count               = length(var.regions)
    name                = "${var.environment}-subnet-${var.regios[count.index]}"
    regiones            = var.regions[count.index]
    network             = google_compute_network.vpc.name
    ip_cidr_range       = cidrsubnet(var.cidr.range, local.newbits, count.index)
}