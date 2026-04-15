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
    instance_type = "t3.micro"
    ami = "ami-05d2d839d4f73aafb" #ubuntu 24.04 LTS in ap-south-1 region

    root_block_device {
        volume_size = 15
        volume_type = "gp3"
    }
    tags = {
      Name = "ec2-automate"
    }
}

#Output:

1. to get providers and setup environment
  terraform init 

2. to check if everything is correct or not
  terraform validate

3. to check what all will be created after apply
  terraform plan
terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated
with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_default_vpc.default will be created
  + resource "aws_default_vpc" "default" {
      + arn                                  = (known after apply)
      + cidr_block                           = (known after apply)
      + default_network_acl_id               = (known after apply)
      + default_route_table_id               = (known after apply)
      + default_security_group_id            = (known after apply)
      + dhcp_options_id                      = (known after apply)
      + enable_dns_hostnames                 = true
      + enable_dns_support                   = true
      + enable_network_address_usage_metrics = (known after apply)
      + existing_default_vpc                 = (known after apply)
      + force_destroy                        = false
      + id                                   = (known after apply)
      + instance_tenancy                     = (known after apply)
      + ipv6_association_id                  = (known after apply)
      + ipv6_cidr_block                      = (known after apply)
      + ipv6_cidr_block_network_border_group = (known after apply)
      + main_route_table_id                  = (known after apply)
      + owner_id                             = (known after apply)
      + region                               = "ap-south-1"
      + tags                                 = {
          + "Name" = "Default VPC"
        }
      + tags_all                             = {
          + "Name" = "Default VPC"
        }
    }

  # aws_instance.my_instance will be created
  + resource "aws_instance" "my_instance" {
      + ami                                  = "ami-05d2d839d4f73aafb"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + enable_primary_ipv6                  = (known after apply)
      + force_destroy                        = false
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t3.micro"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = "terra-key-ec2"
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_group_id                   = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + region                               = "ap-south-1"
      + secondary_private_ips                = (known after apply)
      + security_groups                      = [
          + "automate-sg",
        ]
      + source_dest_check                    = true
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = (known after apply)
      + tags                                 = {
          + "Name" = "ec2-automate"
        }
      + tags_all                             = {
          + "Name" = "ec2-automate"
        }
      + tenancy                              = (known after apply)
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)

      + capacity_reservation_specification (known after apply)

      + cpu_options (known after apply)

      + ebs_block_device (known after apply)

      + enclave_options (known after apply)

      + ephemeral_block_device (known after apply)

      + instance_market_options (known after apply)

      + maintenance_options (known after apply)

      + metadata_options (known after apply)

      + network_interface (known after apply)

      + primary_network_interface (known after apply)

      + private_dns_name_options (known after apply)

      + root_block_device {
          + delete_on_termination = true
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + tags_all              = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = 15
          + volume_type           = "gp3"
        }

      + secondary_network_interface (known after apply)
    }

  # aws_key_pair.my_key will be created
  + resource "aws_key_pair" "my_key" {
      + arn             = (known after apply)
      + fingerprint     = (known after apply)
      + id              = (known after apply)
      + key_name        = "terra-key-ec2"
      + key_name_prefix = (known after apply)
      + key_pair_id     = (known after apply)
      + key_type        = (known after apply)
      + public_key      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDG1rIHO4+OxrIdBMb0udk78ORdpoQi1EpeM+UbVtO2WNNvrdsMqkQZuRAimuCjV2ir5SHFI9KBARNN/vY5yyXbO4Pm6A5NBPsbzHB18a1Vv6pGuRnbcNIuf1eWlngrpRXyA7I+WOhhjk85783I2KGHOsDuUojsvFYLESn4kK0pRhRHRHg9RWwiUhg0989qD+93cKECI9ccB6N0ouNeL4FUwrkdUzD+CGFbodQ8Tg4C4SX4xGtclOmvLIzD0qBzsG9wvTT1uoJGTF7cOBrcMfrin6rleKTtZ5QM5jbXA2mZql74hLBP9k5wg9dE3BV96JYLnio2cZ7S7hX/6GstEQe10x//ceVJafoFhb98yfagn6tW6oHh98xd3rCWZ//To6ZlXbR81/d3o3pdAT6nl6eDzhQYoZU1arxzeoPRfrml1iS9S8lOHvHdUe4OCjKyG7EymbGr49EAESS/db9qRCTfFk8d1Uf66ZMlcnNckgpLLYTmT9YJAZPYA3q3RENDc2c= admine@admine-desktop"
      + region          = "ap-south-1"
      + tags_all        = (known after apply)
    }

  # aws_security_group.my_security_group will be created
  + resource "aws_security_group" "my_security_group" {
      + arn                    = (known after apply)
      + description            = "This will add a tf generated security group to allow traffic to ec2 instance"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                  ]
                + description      = "Allow all outbound traffic"
                + from_port        = 0
                + ipv6_cidr_blocks = []
                + prefix_list_ids  = []
                + protocol         = "-1"
                + security_groups  = []
                + self             = false
                + to_port          = 0
              },
          ]
        + id                     = (known after apply)
        + ingress                = [
            + {
                + cidr_blocks      = [
                    + "0.0.0.0/0",
                  ]
                + description      = "Allow HTTP access from anywhere"
                + from_port        = 80
                + ipv6_cidr_blocks = []
                + prefix_list_ids  = []
                + protocol         = "tcp"
                + security_groups  = []
                + self             = false
                + to_port          = 80
              },
            + {
                + cidr_blocks      = [
                    + "0.0.0.0/0",
                  ]
                + description      = "Allow SSH access from anywhere"
                + from_port        = 22
                + ipv6_cidr_blocks = []
                + prefix_list_ids  = []
                + protocol         = "tcp"
                + security_groups  = []
                + self             = false
                + to_port          = 22
              },
            + {
                + cidr_blocks      = [
                    + "0.0.0.0/0",
                  ]
                + description      = "Allow access to port 8000 for app from anywhere"
                + from_port        = 8000
                + ipv6_cidr_blocks = []
                + prefix_list_ids  = []
                + protocol         = "tcp"
                + security_groups  = []
                + self             = false
                + to_port          = 8000
              },
          ]
        + name                   = "automate-sg"
        + name_prefix            = (known after apply)
        + owner_id               = (known after apply)
        + region                 = "ap-south-1"
        + revoke_rules_on_delete = false
        + tags                   = {
            + "Name" = "automate-sg"
          }
        + tags_all               = {
          + "Name" = "automate-sg"
          }
        + vpc_id                 = (known after apply)
      }

  Plan: 4 to add, 0 to change, 0 to destroy.

  ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────

  Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these
  actions if you run "terraform apply" now.

4. error for terraform apply as I didn't give permission to user in aws 
  terraform apply
   Error: importing EC2 Key Pair (terra-key-ec2): operation error EC2: ImportKeyPair, https response error StatusCode: 403, RequestID: 6899871e-fcdf-40e3-8daa-c4057622fe55, api error UnauthorizedOperation: You are not authorized to perform this operation. User: arn:aws:iam::045511193332:user/terra-admin is not authorized to perform: ec2:ImportKeyPair on resource: arn:aws:ec2:ap-south-1:045511193332:key-pair/terra-key-ec2 because no identity-based policy allows the ec2:ImportKeyPair action. Encoded authorization failure message: AJW84UUDAY2ELFWUcjs8HwuzMgPz4ehE8gOQPDTjzd-ExVKkahC71FBC6vmlsUd83OYciixiZ7NQseSKg0_jSU6bVGRWqR5-U3e-zIAUmyLaoxO3MvcQFRCLZHGGfE0hc-twlbs4d4b5CVY4tZNiAsL593JeZ-LFO5BcNds4xfGeqCSA2TLWiGqRUJca4SYkdPUGBumypA22CNCD7BjA9dxmVmeehr1q9_bQdSQS0I2zotZBH8DA1ii27zqIj0KM_yHqLpADgMUAI5c7_2ePp2RmZS99cnaAcB8aQDf1Zr1dy0yt5Ax5GNTxeTeahYPEpXF21SEf-Mz1z5WmiF3on_CDzextuiTRZMQYmyMeA_FxxoTN-ymwZyDhfVaXhZg7Z0BDnZSaulNjSK8ooqefLeDvNKFsNXlQGJpy5oiD4EFqKpZde4xLalrWs_1RrEQiXcSgcqc2zQkwsT9pCUcnAXJ7S6BaTzLCLQ1bb55CpFzQb1PAfgY-3uXo00AiZFVIxaffLi3DVEVx1ng0RU4B7L37PPDjLfRQXsN0WNntv2G5
│ 
│   with aws_key_pair.my_key,
│   on ec2.tf line 3, in resource "aws_key_pair" "my_key":
│    3: resource "aws_key_pair" "my_key" {
│ 
╵
╷
│ Error: reading EC2 Default VPC (): operation error EC2: DescribeVpcs, https response error StatusCode: 403, RequestID: cfeb0b63-a0b2-40fb-a2ef-ed4fa0ff37f6, api error UnauthorizedOperation: You are not authorized to perform this operation. User: arn:aws:iam::045511193332:user/terra-admin is not authorized to perform: ec2:DescribeVpcs because no identity-based policy allows the ec2:DescribeVpcs action
│ 
│   with aws_default_vpc.default,
│   on ec2.tf line 11, in resource "aws_default_vpc" "default":
│   11: resource "aws_default_vpc" "default" {
│ 
╵

5. after giving permission to user
  Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

  aws_default_vpc.default: Creating...
  aws_key_pair.my_key: Creating...
  aws_key_pair.my_key: Creation complete after 0s [id=terra-key-ec2]
  aws_default_vpc.default: Creation complete after 1s [id=vpc-09af37a9b06c483ef]
  aws_security_group.my_security_group: Creating...
  aws_security_group.my_security_group: Creation complete after 2s [id=sg-0c29d05041f89e801]
  aws_instance.my_instance: Creating...
  aws_instance.my_instance: Still creating... [00m10s elapsed]
  aws_instance.my_instance: Creation complete after 12s [id=i-070056c63343b4f15]

  Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

6. instance created through terraform alongwith VPC and security groups.
  change file permissions of key and try to ssh and check if we can login and connect to ecc2 on local or not
  ssh -i terra-key-ec2 ubuntu@ec2-43-204-32-198.ap-south-1.compute.amazonaws.com

7. to delete instance and related resources
  terraform destroy -auto-approve
  aws_key_pair.my_key: Refreshing state... [id=terra-key-ec2]
  aws_default_vpc.default: Refreshing state... [id=vpc-09af37a9b06c483ef]
  aws_security_group.my_security_group: Refreshing state... [id=sg-0c29d05041f89e801]
  aws_instance.my_instance: Refreshing state... [id=i-070056c63343b4f15]

  Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
  symbols:
    - destroy

  Plan: 0 to add, 0 to change, 4 to destroy.
  aws_instance.my_instance: Destroying... [id=i-070056c63343b4f15]
  aws_instance.my_instance: Still destroying... [id=i-070056c63343b4f15, 00m10s elapsed]
  aws_instance.my_instance: Still destroying... [id=i-070056c63343b4f15, 00m20s elapsed]
  aws_instance.my_instance: Destruction complete after 30s
  aws_key_pair.my_key: Destroying... [id=terra-key-ec2]
  aws_security_group.my_security_group: Destroying... [id=sg-0c29d05041f89e801]
  aws_key_pair.my_key: Destruction complete after 0s
  aws_security_group.my_security_group: Destruction complete after 0s
  aws_default_vpc.default: Destroying... [id=vpc-09af37a9b06c483ef]
  aws_default_vpc.default: Destruction complete after 0s

  Destroy complete! Resources: 4 destroyed.

  ec2 will be terminated along with associated resources.
