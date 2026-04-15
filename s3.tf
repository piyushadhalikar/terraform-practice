#this is a terraform script to create s3 bucket

resource aws_s3_bucket my_s3_bucket {
	
	bucket = "terraform-bucket"
}


#Output

1. to automatically download aws provider to create s3 we need to do terraform init again to modify environment
  terraform init
  Initializing the backend...
  Initializing provider plugins...
  - Finding latest version of hashicorp/aws...
  - Reusing previous version of hashicorp/local from the dependency lock file
  - Installing hashicorp/aws v6.40.0...
  - Installed hashicorp/aws v6.40.0 (signed by HashiCorp)
  - Using previously-installed hashicorp/local v2.8.0
  Terraform has made some changes to the provider dependency selections recorded
  in the .terraform.lock.hcl file. Review those changes and commit them to your
  version control system if they represent changes you intended to make.

  Terraform has been successfully initialized!

  You may now begin working with Terraform. Try running "terraform plan" to see
  any changes that are required for your infrastructure. All Terraform commands
  should now work.

  If you ever set or change modules or backend configuration for Terraform,
  rerun this command to reinitialize your working directory. If you forget, other
  commands will detect it and remind you to do so if necessary.

2. 
