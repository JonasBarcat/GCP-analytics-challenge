variable "project_id" {
  description = "The ID of the project in which the resource belongs"
}

variable "name" {
  description = "A user-defined name of the function."
  type        = string
  default     = "http-enpoint"
}

variable "location" {
  description = "The location of this cloud function."
  type        = string
  default     = "us-central1"
}

variable "description" {
  description = "User-provided description of a function."
  type        = string
  default     = "Cloud function for HTTP API endpoint"
}


variable "runtime" {
  description = "The runtime in which to run the function"
  type        = string
  default     = "python"
}

variable "entry_point" {
  description = "The name of the function (as defined in source code) that will be executed."
  type        = string
  default     = "main"
}

variable "bucket_name" {
  description = "name of bucket where code is allocated"
  type        = string
}

variable "bucket_object_name" {
  description = "object name which contains the function source code"
  type        = string
}