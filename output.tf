output "ec2_public_ip" {
    value = aws_instance.my_instance[*].public_ip
    description = "The public IP address of the EC2 instance"
}
#show output on terminal after terraform apply
output "ec2_public_dns" {
    value = aws_instance.my_instance[*].public_dns # * is used because there are more than 1 instance created using count meta argument.
    description = "The public DNS name of the EC2 instance"
}

output "ec2_instance_private_ip" {
    value = aws_instance.my_instance[*].private_ip
    description = "The private IP address of the EC2 instance"
}

#Output:

1. after apply for 1 instance
  terraform apply 
  Plan: 4 to add, 0 to change, 0 to destroy.

  Changes to Outputs:
    + ec2_instance_private_ip = (known after apply)
    + ec2_public_dns           = (known after apply)
    + ec2_public_ip            = (known after apply)

  Do you want to perform these actions?
    Terraform will perform the actions described above.
    Only 'yes' will be accepted to approve.

    Enter a value: yes
  Outputs:

  ec2_instance_private_ip = "172.31.37.61"
  ec2public_dns = "ec2-43-205-206-44.ap-south-1.compute.amazonaws.com"
  ec2public_ip = "43.205.206.44"

2. if count is more than one [i.e. count =2]
    Changes to Outputs:
  + ec2_instance_private_ip = [
      + (known after apply),
      + (known after apply),
    ]
  + ec2_public_dns          = [
      + (known after apply),
      + (known after apply),
    ]
  + ec2_public_ip           = [
      + (known after apply),
      + (known after apply),
    ]

─────────────────────────────
