#Looker instance creation
resource "google_looker_instance" "looker-instance" {
  name               = var.looker_instance_name
  platform_edition   = var.looker_edition
  region             = "us-central1"
  public_ip_enabled  = true
  admin_settings {
    allowed_email_domains = ["google.com"]
  }
  // User metadata config is only available when platform edition is LOOKER_CORE_STANDARD.
  user_metadata {
    additional_developer_user_count = 10 
    additional_standard_user_count  = 10
    additional_viewer_user_count    = 10
  }
  maintenance_window {
    day_of_week = "THURSDAY"
    start_time {
      hours   = 22
      minutes = 0
      seconds = 0
      nanos   = 0
    }
  }
  deny_maintenance_period {    
    start_date {
      year = 2050
      month = 1
      day = 1
    }
    end_date {
      year = 2050
      month = 2
      day = 1
    }
    time {
      hours = 10
      minutes = 0
      seconds = 0
      nanos = 0
    }
  }

  #the following credentials can be created from Creadentials page. Its optional, you can use SA instead.
/*   oauth_config {
    client_id = "my-client-id"
    client_secret = "my-client-secret"
  } */
}

#BigQuery and Looker conector configuration.
resource "looker_connection" "bigquery_connection" {
  name         = var.looker_bq_connection
  host         = var.project_id
  user         = var.service_account
  certificate  = filebase64("path/to/sa.json")
  file_type    = ".json"
  database     = var.bq_dataset
  tmp_db_name  = "tmp_dataset_name"
  dialect_name = "bigquery_standard_sql"
}