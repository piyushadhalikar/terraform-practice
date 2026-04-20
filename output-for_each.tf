output "ec2_public_ip" {
    value = [
        for instance in aws_instance.my_instance : instance.public_ip
    ]
    description = "The public IP address of the EC2 instance"
}

output "ec2_public_dns" {
    value = [
        for instance in aws_instance.my_instance : instance.public_dns
    ]
    description = "The public DNS name of the EC2 instance"
}

output "ec2_private_ip" {
    value = [
        for instance in aws_instance.my_instance : instance.private_ip
    ]
    description = "The private IP address of the EC2 instance"
}
#Output:

1. for both instance created by for_each
 Changes to Outputs:
  + ec2_private_ip = [
      + (known after apply),
      + (known after apply),
    ]
  + ec2_public_dns = [
      + (known after apply),
      + (known after apply),
    ]
  + ec2_public_ip  = [
      + (known after apply),
      + (known after apply),
    ]
