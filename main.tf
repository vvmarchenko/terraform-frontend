module "frontend-conduit" {
  source = "./modules"
  bucket_name = "my-bucket-vmarchenko"
  profile_name = "default"
  owner_tag = "Vladyslav Marchenko"
  project_tag = "conduit"
}

output "cloudfront_domain_name" {
  value = module.frontend-conduit.cloudfront_domain_name
}
