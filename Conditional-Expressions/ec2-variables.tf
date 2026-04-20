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
    for_each = tomap({
        "ec2_automate_micro" = "t3.micro",    
        "ec2_automate_small" = "t3.small"
    })#for_each meta argument to create multiple ec2 instances with different instance types using map function

    depends_on = [aws_security_group.my_security_group, aws_key_pair.my_key] #to ensure security group is created before ec2 instance
    # count = 2 # meta argument to create 2 ec2 instances
    key_name = aws_key_pair.my_key.key_name #interpolation to get key name from key pair resource
    security_groups = [aws_security_group.my_security_group.name]
    instance_type = each.value #var.ec2_instance_type
    ami = var.ec2_ami_id #ubuntu 24.04 LTS in ap-south-1 region
    user_data = file("install_nginx.sh") #to install nginx on ec2 instance using user data script

    root_block_device {
        volume_size = var.env == "prd" ? 20 : var.ec2_default_root_storage_size #conditional expression to set root storage size based on environment variable
        volume_type = "gp3"
    }
    tags = {
      Name = each.key   # "ec2-automate"
    }
}
      
#Output:

1. when env = prd volume = 20
  + root_block_device {
          + delete_on_termination = true
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + tags_all              = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = 20
          + volume_type           = "gp3"
        }

2. when env = dev volume = 10(default)
  + root_block_device {
          + delete_on_termination = true
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + tags_all              = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = 10
          + volume_type           = "gp3"
        }
