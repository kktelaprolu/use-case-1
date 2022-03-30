provider "google" {

}

terraform {
  backend "gcs" {
    bucket = "state-file-bucket-24"

  }
}

module spanner {
  source = "./regional_deployment/spanner"
  instance_name			= var.instance_name
  config			= var.config
  display_name			= var.display_name
  num_nodes			= var.num_nodes
  labels			= var.labels
  project			= var.project
  force_destroy			= var.force_destroy
  databases			= var.databases  
}
