#Bigquery dataset resource.
resource "google_bigquery_dataset" "default-dataset" {
  dataset_id                  = var.dataset_id
  friendly_name               = var.friendly_name
  description                 = "This dataset contains the data ingested from an API"
  location                    = "US"
  default_table_expiration_ms = 3600000

  labels = {
    env = "default"
  }
}

#Map of bigquery table resources being provisioned. We can automate table creation process via schemafiles but this keep this structure for simplicity
resource "google_bigquery_table" "default-table" {
  dataset_id = google_bigquery_dataset.default-dataset.dataset_id
  table_id   = var.table_id

  time_partitioning {
    type = "DAY"
  }

  labels = {
    env = "default"
  }


#We can import the schema from a json file. We suppose this is the schema format
  schema = <<EOF
[
  {
    "name": "FirstName",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "client's first name"
  },
]
EOF

}

