output "bucket_url" {
  value = "https://storage.googleapis.com/${google_storage_bucket.bucket.name}"
}