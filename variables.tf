variable "availability_zone_names" {
  type    = string
  default = "us-west-1a"
}

variable "project_id" {
  type    = string
  default = "latam-test"
}

variable "region" {
  type    = string
  default =  "us-east1"
}

variable "service_account" {
  type    = string
  default =  "sa-demo-tf-sbx@PROJECT_ID.iam.gserviceaccount.com"
}

