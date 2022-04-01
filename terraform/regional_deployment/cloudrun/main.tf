locals {
  env = toset([
    for e in var.env: {
      key = e.key
      value = e.value
      secret = {
        name = e.secret
        version = e.version
      }
    }
  ])
}

resource "google_cloud_run_service" "cloudrun" {
  name     = var.name
  location = var.location
  autogenerate_revision_name = true
  project = var.project

  template {
    spec {
	  container_concurrency = var.container_concurrency
	  timeout_seconds  = var.timeout
	  service_account_name = var.service_account_name
      containers {
        image = var.image
		ports {
          name = var.http2 ? "h2c" : "http1"
          container_port = var.port
        }
	resources {
          limits = {
            cpu = "${var.cpus * 1000}m"
            memory = "${var.memory}Mi"
          }
        }
	dynamic env {
          for_each = [for e in local.env: e if e.value != null]

          content {
            name = env.value.key
            value = env.value.value
          }
        }
       dynamic env {
          for_each = [for e in local.env: e if e.secret.name != null]

          content {
            name = env.value.key
            value_from {
              secret_key_ref {
                name = env.value.secret.name
                key = env.value.secret.version
              }
            }
          }
        }
       }
    }
    metadata {
	  labels = var.labels
	  namespace = var.project
      annotations = {
        "autoscaling.knative.dev/maxScale"      = "5"
        "run.googleapis.com/client-name"        = "terraform"
        "client.knative.dev/user-image" 	= var.image
      }
    }
  }  
  
  

  traffic {
    percent = 100
    latest_revision = var.revision == null
    revision_name = var.revision != null ? "${var.name}-${var.revision}" : null
  }
}
