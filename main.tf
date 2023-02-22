module "frontend-conduit" {
  source = "./modules"
  bucket_name = var.bucket_name
  profile_name = var.profile_name
  owner_tag = var.owner_tag
  project_tag = var.project_tag
}

output "cloudfront_domain_name" {
  value = module.frontend-conduit.cloudfront_domain_name
}

variable "bucket_name" {
  type = string
  description = "The your unique S3 Bucket name"
}

variable "region_name" {
  type = string
  description = "Choose any preferred region"
  default = "us-east-1"
}

variable "profile_name" {
  type = string
  description = "The your profile name in AWS"
}

variable "owner_tag" {
  type = string
  description = "The owner tag who create this project"
}

variable "project_tag" {
  type = string
  description = "The project tag name"
}
