resource "google_storage_bucket" "cloudstorage" {
  name          = var.bucket_name
  location      = var.bucket_location
  force_destroy = true
  storage_class = var.storage_class

  uniform_bucket_level_access = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }

  public_access_prevention = "enforced"

}
