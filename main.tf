module "frontend-conduit" {
  source = "./modules"
  bucket_name = "my-bucket-vmarchenko"
  profile_name = "default"
  owner_tag = "Vladyslav Marchenko"
  project_tag = "conduit"
}

