resource "google_spanner_database" "spanner_database" {
  instance = var.instance-name
  project = var.project
  name = var.database
  deletion_protection = var.deletion_protection
  ddl = var.ddl
 
  encryption_config {
      
	  
	  content {
	  
                      kms_key_name = var.kms_key_name
	          }
	  
                           }

                                              }
