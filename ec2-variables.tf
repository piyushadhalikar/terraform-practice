# key pair to login to ec2 instance

resource "aws_key_pair" "my_key" {
  key_name   = "terra-key-ec2"
  public_key = file("terra-key-ec2.pub")
  
}

# VPC and security group to allow traffic to ec2 instance

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_security_group" "my_security_group" {
    name = "automate-sg"
    description = "This will add a tf generated security group to allow traffic to ec2 instance"
    vpc_id = aws_default_vpc.default.id #interpolation to get vpc id from default vpc resource
    
    #inbound rules
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"] #list of allowed IPs
        description = "Allow SSH access from anywhere"
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow HTTP access from anywhere"
    }
    ingress {
        from_port = 8000
        to_port = 8000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow access to port 8000 for app from anywhere"
    }
    #outbound rules
    egress {
        from_port = 0
        to_port = 0
        protocol = -1 # semantically equivalent to all ports
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow all outbound traffic"
    }
    tags = {
        Name = "automate-sg"
    }
}
# ec2 instance
resource "aws_instance" "my_instance" {
    key_name = aws_key_pair.my_key.key_name #interpolation to get key name from key pair resource
    security_groups = [aws_security_group.my_security_group.name]
    instance_type = var.ec2_instance_type
    ami = var.ec2_ami_id #ubuntu 24.04 LTS in ap-south-1 region

    root_block_device {
        volume_size = var.ec2_root_storage_size
        volume_type = "gp3"
    }
    tags = {
      Name = "ec2-automate"
    }
}
