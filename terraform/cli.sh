terraform state rm aws_s3_bucket.bucket-name
terraform state import aws_s3_bucket.bucket-name bucket-name


# this is handy to move the state somewhere else. You still need to do an init after this.
terraform init -migrate-state

terraform fmt -recursive