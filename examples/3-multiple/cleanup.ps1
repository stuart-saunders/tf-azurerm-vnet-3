terraform destroy --auto-approve
Remove-Item -Recurse -Force .terraform*
Remove-Item -Recurse -Force terraform.tfstate*