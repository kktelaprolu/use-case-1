module spanner {
  source = "../"
  name				= var.instance_name
  config			= var.config
  display_name		= var.display_name
  num_nodes			= var.num_nodes
  processing_units	= var.processing_units
  labels			= var.labels
  project			= var.project
  force_destroy		= var.force_destroy
  databases			= var.databases  
}