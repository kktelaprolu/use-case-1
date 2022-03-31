provider "google" {

}

terraform {
  backend "gcs" {
    bucket = "state-file-bucket-24"

  }
}


module spanner {
  source = "./regional_deployment/spanner"
  instance_name			= "spanner-test-instance"
  config			= "regional-europe-west1"
  display_name			= "tf-spanner-test-instance"
  num_nodes			= 1
  project			= var.project
  force_destroy			= true
  databases			= [
    { 
      name = "database-test-1",
      ddl = [
        "CREATE TABLE t1 (t1 INT64 NOT NULL,) PRIMARY KEY(t1)"
        ]
     kms_key_name = ""
    },
    { 
      name = "database-test-2",
      ddl = [
        "CREATE TABLE t2 (t2 INT64 NOT NULL,) PRIMARY KEY(t2)"
        ]
     kms_key_name = ""
    },
  ]
}

module spanner2 {
  source = "./regional_deployment/spanner"
  instance_name				= "spanner-test-instance-2"
  config			= "regional-europe-west1"
  display_name			= "tf-spanner-test-instance-2"
  num_nodes			= 1
  project			= var.project
  force_destroy			= true
  databases	= [
    { 
      name = "database-test-1",
      ddl = [
        "CREATE TABLE t1 (t1 INT64 NOT NULL,) PRIMARY KEY(t1)"
        ]
      kms_key_name = ""
    },
    { 
      name = "database-test-2",
      ddl = []
      kms_key_name = ""
    },
  ]
}
module spanner-database {
  source = "./regional_deployment/spanner-module"
  instance-name  = module.spanner2.instance_id
  project = var.project
  database = "db1"
  ddl = data.external.ddl.result
  kms_key_name = ""
  deletion_protection = false
 
}


data "external" "ddl" {
  program = ["/bin/bash", "cat scripts/ddl-file.txt"]
 }

