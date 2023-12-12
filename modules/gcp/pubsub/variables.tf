variable "topic_name" {
    type    = string
}

variable "topic_message_retention_duration" {
    type = string
    default = "86600s"
}

variable "push_bq_name" {
    type = string
}

#push subcription configuration for bq
variable "project_id" {
    type = string
}

variable "dataset_id" {
    type = string
}

variable "table_id" {
    type = string
}