output "vpc_id" {
    description = "vpc_id"
    value = module.vpc.vpc_id
}

output "subnet_id" {
    description = "subnet_id"
    value = module.vpc.subnet_id
  
}
output "ec2_id" {
    description = "The ID of the EC2 instance"
    value = module.ec2.ec2_id  
}
output "ec2_public_ip" {
    description = "The ID of the EC2 instance"
    value = module.ec2.public_ip 
}
