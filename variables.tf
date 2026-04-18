variable "ec2_instance_type" {
    description = "The type of EC2 instance to create"
    default     = "t3.micro"
    type       = string    
  
}

variable "ec2_root_storage_size" {
    description = "The size of the root storage volume in GB"
    default     = 15
    type        = number    
  
}

variable "ec2_ami_id" {
    description = "The AMI ID to use for the EC2 instance"
    default     = "ami-05d2d839d4f73aafb" #ubuntu 24.04 LTS in ap-south-1 region
    type        = string
}
