locals {
  project = var.project_id # Google Cloud Platform Project ID
}

resource "google_cloudfunctions2_function" "function" {
  name = var.name
  location = var.location
  description = var.description

  build_config {
    runtime = var.runtime
    entry_point = var.entry_point  # The name of the function that will be executed
    source {
      storage_source {
        bucket = var.bucket_name
        object = var.bucket_object_name
      }
    }
  }

  service_config {
    max_instance_count  = 1
    available_memory    = "256M"
    timeout_seconds     = 60
  }
}

