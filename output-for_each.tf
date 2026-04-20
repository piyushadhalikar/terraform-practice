output "ec2_public_ip" {
    value = [
        for instance in aws_instance.my_instance : instance.public_ip
    ]
    description = "The public IP address of the EC2 instance"
}

#Output:

1. ip showing for both instance created by for_each
  Changes to Outputs:
  + ec2_public_ip = [
      + (known after apply),
      + (known after apply),
    ]
