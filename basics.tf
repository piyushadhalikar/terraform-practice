1. terraform --version
  Terraform v1.14.8
  on linux_amd64

2. tf file syntax
  vim file.tf
  <block> <parameters>{
          arguments
}

3. after file created
  terraform init (terraform environment gets created)
  Initializing the backend...
  Initializing provider plugins...
  - Finding latest version of hashicorp/local...
  - Installing hashicorp/local v2.8.0...
  - Installed hashicorp/local v2.8.0 (signed by HashiCorp)
  Terraform has created a lock file .terraform.lock.hcl to record the provider
  selections it made above. Include this file in your version control repository
  so that Terraform can guarantee to make the same selections by default when
  you run "terraform init" in the future.
  
  Terraform has been successfully initialized!

  You may now begin working with Terraform. Try running "terraform plan" to see
  any changes that are required for your infrastructure. All Terraform commands
  should now work.

  If you ever set or change modules or backend configuration for Terraform,
  rerun this command to reinitialize your working directory. If you forget, other
  commands will detect it and remind you to do so if necessary.

4. after terraform init 
  ls -a
  .  ..  .terraform  .terraform.lock.hcl  file.tf
5. to check if script is correct or not
  terraform validate
  Success! The configuration is valid.

6. to check what script in file will do #dry run output
  terraform plan
  Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

  Terraform will perform the following actions:

    # local_file.my_file will be created
    + resource "local_file" "my_file" {
        + content              = "This is an automated generated file"
        + content_base64sha256 = (known after apply)
        + content_base64sha512 = (known after apply)
        + content_md5          = (known after apply)
        + content_sha1         = (known after apply)
        + content_sha256       = (known after apply)
        + content_sha512       = (known after apply)
        + directory_permission = "0777"
        + file_permission      = "0777"
        + filename             = "automate.txt"
        + id                   = (known after apply)
      }

    Plan: 1 to add, 0 to change, 0 to destroy.

  ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

  Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform
  apply" now.

7. to apply the script
  terraform apply

  Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
    + create

  Terraform will perform the following actions:

    # local_file.my_file will be created
    + resource "local_file" "my_file" {
        + content              = "This is an automated generated file"
        + content_base64sha256 = (known after apply)
        + content_base64sha512 = (known after apply)
        + content_md5          = (known after apply)
        + content_sha1         = (known after apply)
        + content_sha256       = (known after apply)
        + content_sha512       = (known after apply)
        + directory_permission = "0777"
        + file_permission      = "0777"
        + filename             = "automate.txt"
        + id                   = (known after apply)
      }

  Plan: 1 to add, 0 to change, 0 to destroy.

  Do you want to perform these actions?
    Terraform will perform the actions described above.
    Only 'yes' will be accepted to approve.

    Enter a value: yes

  local_file.my_file: Creating...
  local_file.my_file: Creation complete after 0s [id=33bb78cce1d40ecab97a4adf69318f0656f1c1f2]

  Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

7. output 
  cat automate.txt 
  This is an automated generated file

8. to delete
  terraform destroy
  local_file.my_file: Refreshing state... [id=33bb78cce1d40ecab97a4adf69318f0656f1c1f2]

  Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
    - destroy

  Terraform will perform the following actions:

    # local_file.my_file will be destroyed
    - resource "local_file" "my_file" {
        - content              = "This is an automated generated file" -> null
        - content_base64sha256 = "leBJ3zRmG43hvrHOB4+WIJjUwV9FAnSNLLWuMKUTvvc=" -> null
        - content_base64sha512 = "HfhFV6mNIw9esIAcZmlsSQELeVSC0pfLqP+V4HGCdGcFc4H4HZ5gvRaiWT2ZbBgIdWBKyXA6fuP3dSbFYYKibA==" -> null
        - content_md5          = "941cecf06de10d12d6f594e69d3d7904" -> null
        - content_sha1         = "33bb78cce1d40ecab97a4adf69318f0656f1c1f2" -> null
        - content_sha256       = "95e049df34661b8de1beb1ce078f962098d4c15f4502748d2cb5ae30a513bef7" -> null
        - content_sha512       = "1df84557a98d230f5eb0801c66696c49010b795482d297cba8ff95e071827467057381f81d9e60bd16a2593d996c180875604ac9703a7ee3f77526c56182a26c" -> null
        - directory_permission = "0777" -> null
        - file_permission      = "0777" -> null
        - filename             = "automate.txt" -> null
        - id                   = "33bb78cce1d40ecab97a4adf69318f0656f1c1f2" -> null
      }

  Plan: 0 to add, 0 to change, 1 to destroy.

  Do you really want to destroy all resources?
    Terraform will destroy all your managed infrastructure, as shown above.
    There is no undo. Only 'yes' will be accepted to confirm.

    Enter a value: yes

  local_file.my_file: Destroying... [id=33bb78cce1d40ecab97a4adf69318f0656f1c1f2]
  local_file.my_file: Destruction complete after 0s

  Destroy complete! Resources: 1 destroyed.

9. to apply changes without user input
  terraform apply -auto-approve

10. to delete without user input
  terraform destroy -auto-approve
