variable "profile_name" {
  type = string
  description = "The your profile name in AWS"
}

variable "region_name" {
  type = string
  description = "Choose any preferred region"
  default = "us-east-1"
}

variable "bucket_name" {
  type = string
  description = "The your unique S3 Bucket name"
}

variable "default_root_object" {
  type = string
  description = "Add your file for main web-page"
  default = "index.html"
}

variable "price_class" {
  type        = string
  description = "The price class for the CDN"
  default = "PriceClass_100"
}

variable "viewer_protocol_policy" {
  type        = string
  description = "The protocol that viewers can use to access the CDN"
  default = "allow-all"
}

variable "min_ttl" {
  type        = number
  description = "The minimum time-to-live for objects in the CDN cache"
  default = 0
}

variable "default_ttl" {
  type        = number
  description = "The default time-to-live for objects in the CDN cache"
  default = 3600
}

variable "max_ttl" {
  type        = number
  description = "The maximum time-to-live for objects in the CDN cache"
  default = 86400
}

variable "environment_tag" {
  type = string
  description = "The global tag for your project"
  default = "production"
}

variable "owner_tag" {
  type = string
  description = "The owner tag who create this project"
}


variable "project_tag" {
  type = string
  description = "The project tag name"
}

variable "origin_access_control_name" {
  type = string
  description = "The name for origin access control"
  default = "Access control for project"
}




