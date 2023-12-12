terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.8.0"
    }
  }
  required_version = "tf version"
}

provider "gcp" {
  project = "latam-test"
  region  = "us-central1"
}



#create storage for API source code upload
module "cloudstorage" {
  source = "/modules/gcp/cloudstorage"

  bucket_name = "bucket-for-api"
  bucket_location = "US"
  project_id = "project-id"
  storage_class = "STANDARD"
}

#API SOURCE CODE UPLOAD
resource "google_storage_bucket_object" "api_code" {
 name         = "api_code"
 source       = "/sources/api_http.py"
 content_type = "text/plain"
 bucket       = "<bucket-id>"
}

#create bigquery dataset and table via module
module "bigquery" {
  source = "/modules/gcp/bigquery"

  dataset_id = "bq-api-dataset"
  friendly_name = "bq-api-dataset"
  table_id = "bq-api-table"
}

module pubsub {
  source = "/modules/gcp/pubsub"

  topic_name = "api-bq-topic"
  push_bq_name = "pusher-to-bq"
  project_id = var.project_id
  dataset_id = "bq-api-dataset"
  table_id = "bq-api-table"
}


#DEPLOY CLOUD FUNCTION
module "cloud_functions2" {
  source  = "/modules/gcp/cloudfunction"

  # Required variables
  function_name  = "HTTP-API"
  project_id     = "<PROJECT_ID>"
  location       = "US"
  runtime        = "python"
  entrypoint     = "query_bigquery"
  storage_source = {
    bucket      = "bucket-for-api"
    object      = "api_http.py"
    generation  = "<GCS_GENERATION>"
  }
}

module "looker" {
  source = "/modules/gcp/looker"

  looker_instance_name = "looker-instance"
  project_id = "<PROJECT_ID>"
  service_account = "<SA>"
  bq_dataset = "bq-api-dataset"
}
