locals {
  env = toset([
    for e in var.env: {
      key = e.name
      value = e.value
    }
  ])

  env_secret = toset([
    for e in var.env_secret: {
      key = e.name
      secret = {
        secret_name = e.secret
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
  metadata {
          labels = var.labels
          namespace = var.project
      annotations = {
        "run.googleapis.com/binary-authorization" = var.binary-auth
        "run.googleapis.com/client-name"        = "terraform"
        "client.knative.dev/user-image"         = var.image
        "run.googleapis.com/ingress"            = var.ingress
      }
    }
  
  lifecycle {
    ignore_changes = [
      template[0].metadata[0].annotations["client.knative.dev/user-image"],
      template[0].metadata[0].annotations["run.googleapis.com/client-name"],
      template[0].metadata[0].annotations["run.googleapis.com/client-version"],
      template[0].metadata[0].annotations["run.googleapis.com/sandbox"],
      metadata[0].annotations["serving.knative.dev/creator"],
      metadata[0].annotations["serving.knative.dev/lastModifier"],
      metadata[0].annotations["run.googleapis.com/ingress-status"],
      metadata[0].annotations["run.googleapis.com/binary-authorization"],
      metadata[0].labels["cloud.googleapis.com/location"],
    ]
  }

  
  
  template {
    spec {
	  container_concurrency = var.container_concurrency
	  timeout_seconds  = var.timeout
	  service_account_name = var.service_account_name
      containers {
        image = var.image
        command = var.entrypoint
        args = var.args
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
          for_each = [for e in local.env_secret: e if e.secret.secret_name != null]

          content {
            name = env.value.key
            value_from {
              secret_key_ref {
                name = env.value.secret.secret_name
                key = env.value.secret.version
              }
            }
          }
        }
       }
     }
  
   metadata {
      labels = var.labels
     annotations = {
        "autoscaling.knative.dev/maxScale"      = var.maxscale
        "autoscaling.knative.dev/minScale"	= var.minscale
        "run.googleapis.com/vpc-access-connector" = var.vpc_connector_name
        "run.googleapis.com/vpc-access-egress" = var.vpc_access_egress
        "run.googleapis.com/execution-environment" = var.execution_environment
      }
  }
  
 }

  traffic {
    percent = 100
    latest_revision = var.revision == null
    revision_name = var.revision != null ? "${var.name}-${var.revision}" : null
  }
}


