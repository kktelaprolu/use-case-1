resource "google_spanner_instance" "spanner_instance" {

  name				= var.instance_name
  config			= var.config
  display_name		= var.display_name
  num_nodes			= var.num_nodes
  processing_units	= var.processing_units
  labels			= var.labels
  project			= var.project
  force_destroy		= var.force_destroy
  
  }
  
  
resource "google_spanner_database" "spanner_database" {
  instance = google_spanner_instance.spanner_instance.name
  project = var.project
  
  for_each = {
  
     for database in var.databases : database.name => database
     
	 }
	 
  name     = each.value.name
  deletion_protection = lookup(each.value, "deletion_protection", false)
  ddl = lookup(each.value, "ddl", null)
  
  
  dynamic encryption_config {
      
	  for_each = (lookup(each.value, "kms_key_name", "") != "") ? [each.value.kms_key_name] : []
	  
	  content {
	  
                      kms_key_name = lookup(each.value, "kms_key_name", null)
	          }
	  
                           }

                                              }
