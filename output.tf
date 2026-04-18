output "ec2public_ip" {
    value = aws_instance.my_instance.public_ip
    description = "The public IP address of the EC2 instance"
}
#show output on terminal after terraform apply
output "ec2public_dns" {
    value = aws_instance.my_instance.public_dns
    description = "The public DNS name of the EC2 instance"
}

output "ec2_instance_private_ip" {
    value = aws_instance.my_instance.private_ip
    description = "The private IP address of the EC2 instance"
}

#Output:

1. after apply
  terraform apply 
  Plan: 4 to add, 0 to change, 0 to destroy.

  Changes to Outputs:
    + ec2_instance_private_ip = (known after apply)
    + ec2public_dns           = (known after apply)
    + ec2public_ip            = (known after apply)

  Do you want to perform these actions?
    Terraform will perform the actions described above.
    Only 'yes' will be accepted to approve.

    Enter a value: yes
  Outputs:

  ec2_instance_private_ip = "172.31.37.61"
  ec2public_dns = "ec2-43-205-206-44.ap-south-1.compute.amazonaws.com"
  ec2public_ip = "43.205.206.44"
