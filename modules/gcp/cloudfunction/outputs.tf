output "function_uri" { 
  value = google_cloudfunctions2_function.function.service_config[0].uri
}

output "id" {
  description = "An identifier for the resource with format `projects/{{project}}/locations/{{location}}/functions/{{name}}`"
  value       = google_cloudfunctions2_function.this.id
}

output "state" {
  description = "Describes the current state of the function"
  value       = google_cloudfunctions2_function.this.state
}