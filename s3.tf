#this is a terraform script to create s3 bucket

resource aws_s3_bucket my_s3_bucket {
	
	bucket = "test-bucket-tf1a2b3c4d"
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
	terraform plan

	Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  	+ create

	Terraform will perform the following actions:

  	# aws_s3_bucket.my_s3_bucket will be created
  	+ resource "aws_s3_bucket" "my_s3_bucket" {
      	+ acceleration_status         = (known after apply)
      	+ acl                         = (known after apply)
      	+ arn                         = (known after apply)
      	+ bucket                      = "terraform-bucket"
      	+ bucket_domain_name          = (known after apply)
      	+ bucket_namespace            = (known after apply)
      	+ bucket_prefix               = (known after apply)
      	+ bucket_region               = (known after apply)
      	+ bucket_regional_domain_name = (known after apply)
      	+ force_destroy               = false
      	+ hosted_zone_id              = (known after apply)
      	+ id                          = (known after apply)
      	+ object_lock_enabled         = (known after apply)
      	+ policy                      = (known after apply)
      	+ region                      = "ap-south-1"
      	+ request_payer               = (known after apply)
      	+ tags_all                    = (known after apply)
      	+ website_domain              = (known after apply)
      	+ website_endpoint            = (known after apply)

      	+ cors_rule (known after apply)

      	+ grant (known after apply)

      	+ lifecycle_rule (known after apply)

      	+ logging (known after apply)

      	+ object_lock_configuration (known after apply)

      	+ replication_configuration (known after apply)

      	+ server_side_encryption_configuration (known after apply)

      	+ versioning (known after apply)

      	+ website (known after apply)
    	}

3. bucket should have a unique name before apply
	terrform apply
	Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  	+ create

	Terraform will perform the following actions:

  	# aws_s3_bucket.my_s3_bucket will be created
  	+ resource "aws_s3_bucket" "my_s3_bucket" {
      	+ acceleration_status         = (known after apply)
      	+ acl                         = (known after apply)
      	+ arn                         = (known after apply)
      	+ bucket                      = "test-bucket-tf1a2b3c4d"
      	+ bucket_domain_name          = (known after apply)
      	+ bucket_namespace            = (known after apply)
      	+ bucket_prefix               = (known after apply)
      	+ bucket_region               = (known after apply)
      	+ bucket_regional_domain_name = (known after apply)
      	+ force_destroy               = false
      	+ hosted_zone_id              = (known after apply)
      	+ id                          = (known after apply)
      	+ object_lock_enabled         = (known after apply)
      	+ policy                      = (known after apply)
      	+ region                      = "ap-south-1"
      	+ request_payer               = (known after apply)
      	+ tags_all                    = (known after apply)
      	+ website_domain              = (known after apply)
      	+ website_endpoint            = (known after apply)

      	+ cors_rule (known after apply)

      	+ grant (known after apply)

      	+ lifecycle_rule (known after apply)

      	+ logging (known after apply)

      	+ object_lock_configuration (known after apply)

      	+ replication_configuration (known after apply)

      	+ server_side_encryption_configuration (known after apply)

      	+ versioning (known after apply)

      	+ website (known after apply)
    	}

	Plan: 1 to add, 0 to change, 0 to destroy.

	Do you want to perform these actions?
  	Terraform will perform the actions described above.
  	Only 'yes' will be accepted to approve.

  	Enter a value: yes

	aws_s3_bucket.my_s3_bucket: Creating...
	aws_s3_bucket.my_s3_bucket: Creation complete after 1s [id=test-bucket-tf1a2b3c4d]

	Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

4. in ec2
	aws s3 ls
	2026-04-15 10:50:30 test-bucket-tf1a2b3c4d

	go and check in aws console if s3 bucket is created or not
	bucket created with same name and region.

5. delete bucket
	terraform destroy
	aws_s3_bucket.my_s3_bucket: Refreshing state... [id=test-bucket-tf1a2b3c4d]
	aws_s3_bucket.my_s3_bucket: Destroying... [id=test-bucket-tf1a2b3c4d]
	aws_s3_bucket.my_s3_bucket: Destruction complete after 1s

	Destroy complete! Resources: 1 destroyed.
	
