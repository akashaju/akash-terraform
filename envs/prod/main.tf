provider "aws" {
    region = var.region
  
}

module "vpc" {
    source = "../../modules/vpc"
    cidr_block = var.cidr_block
    public_subnet_cidr = var.public_subnet_cidr
    env = var.env
  
}

module "ec2" {
    source = "../../modules/ec2"
    ami = var.ami
    instance_type = var.instance_type
    subnet_id     = module.vpc.subnet_id
    vpc_id        = module.vpc.vpc_id
    env = var.env
    key_name = var.key_name
  
}