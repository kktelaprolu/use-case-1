output "name" {
  value = google_cloud_run_service.cloudrun.name
  description = "Name of the service."
}


output "url" {
  value = google_cloud_run_service.cloudrun.status[0].url
  description = "URL at which the service is available."
}

output "id" {
  value = google_cloud_run_service.cloudrun.id
  description = "ID of the created service."
}


