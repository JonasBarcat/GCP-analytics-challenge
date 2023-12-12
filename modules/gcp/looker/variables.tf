variable "looker_instance_name" {
  type = string
  default ="looker-instance"
}

variable "looker_edition" {
  type = string
  default = "LOOKER_CORE_STANDARD"
}

variable "looker_bq_connection.name" {
  type = string
  default = "looker bq connection"
}

variable "project_id" {
  type = string
}

variable "service_account" {
  type = string
  description = "service account for looker connection"
}

#Defines the name of bigquery dataset.
variable "bq_dataset" {
  type = string
}