resource "aws_security_group" "akash_sg" {
    name = "${var.env}-sg"
    vpc_id =  var.vpc_id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

}

resource "aws_instance" "web" {
    subnet_id = var.subnet_id
    ami = var.ami
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.akash_sg.id]
    key_name = var.key_name
    user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install apache2 -y
              systemctl start apache2
              systemctl enable apache2
              echo "<h1>${var.env} server</h1>" > /var/www/html/index.html
              EOF
    tags ={
        Name =  "${var.env}-ec2"
    }            
}