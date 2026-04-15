#terraform block to install aws provider
terraform {
	required_providers {
    	aws = {
      		source  = "hashicorp/aws"
      		version = "6.40.0"
    	}
  	}

}

#Output:

1. terraform init to download or update the provider
  terraform init
  Initializing the backend...
  Initializing provider plugins...
  - Reusing previous version of hashicorp/aws from the dependency lock file
  - Reusing previous version of hashicorp/local from the dependency lock file
  - Using previously-installed hashicorp/aws v6.40.0
  - Using previously-installed hashicorp/local v2.8.0

  Terraform has been successfully initialized!

  You may now begin working with Terraform. Try running "terraform plan" to see
  any changes that are required for your infrastructure. All Terraform commands
  should now work.

  If you ever set or change modules or backend configuration for Terraform,
  rerun this command to reinitialize your working directory. If you forget, other
  commands will detect it and remind you to do so if necessary.

2. aws provider added inside .terraform/ folder
  ubuntu@ip-172-31-34-161:~/terraform-practice/.terraform/providers/registry.terraform.io/hashicorp$ ls
  aws  local

3. install aws cli to connect aws and terraform
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install

4. aws cli version
  aws --version
  aws-cli/2.34.30 Python/3.14.4 Linux/6.17.0-1007-aws exe/x86_64.ubuntu.24

5. configure aws cli
	create user in iam in aws console and create access key for the user in security group for cli
	aws configure

	Tip: You can deliver temporary credentials to the AWS CLI using your AWS Console session by running the command 'aws login'.

