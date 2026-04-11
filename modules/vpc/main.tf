resource "aws_vpc" "akash_vpc" {
    cidr_block = var.cidr_block
    tags = {
      Name = "${var.env}-vpc"
    }
}
resource "aws_subnet" "public" {
    vpc_id = aws_vpc.akash_vpc.id
    cidr_block = var.public_subnet_cidr
    map_public_ip_on_launch = true

    tags = {
        Name = "${var.env}-public-subnet"
    }
   
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.akash_vpc.id
    tags = {
      Name = "${var.env}-akash-igw"
    }
  
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.akash_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
      Name = "${var.env}-akash-rt"
    }
}

resource "aws_route_table_association" "public_assoc" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.public_rt.id
}