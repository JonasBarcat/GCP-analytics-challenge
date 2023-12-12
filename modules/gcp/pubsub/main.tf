#create topic
resource "google_pubsub_topic" "topic" {
  name = var.topic_name

  message_retention_duration = var.topic_message_retention_duration
}

#Pub/Sub initiates requests to BigQuery to deliver messages
resource "google_pubsub_subscription" "push_bq" {
  name  = var.push_bq_name
  topic = var.topic_name

  bigquery_config {
    table = "${var.project_id}.${var.dataset_id}.${var.table_id}"
  }

  depends_on = [google_project_iam_member.viewer, google_project_iam_member.editor]
}


#We should consider roles and permissions. TBD
/* 
resource "google_project_iam_member" "viewer" {
  project = data.google_project.project.project_id
  role   = "roles/bigquery.metadataViewer"
  member = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "editor" {
  project = data.google_project.project.project_id
  role   = "roles/bigquery.dataEditor"
  member = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
}
 */
