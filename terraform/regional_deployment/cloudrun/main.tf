resource "google_cloud_run_service" "cloudrun" {
  name     = var.name
  location = var.location
  autogenerate_revision_name = true

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
  }
  

  traffic {
    percent = 100
    latest_revision = var.revision == null
    revision_name = var.revision != null ? "${var.name}-${var.revision}" : null
  }
}
