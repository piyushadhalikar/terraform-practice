1. terraform state list
  to show all created resources and its details

2. terraform state show aws_key_pair.key_name
  to show details of specific resource

3. terraform state rm aws_key_pair.key_name
  delete specific resource from state file but it will be present in aws console

4. terraform import aws_key_pair.key_name key-03a1770baed13c390
  to import deleted key from aws into terraform
