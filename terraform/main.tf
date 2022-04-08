provider "google" {

}

/*
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


#module spanner-database {
#  source = "./regional_deployment/spanner-module"
#  instance-name  = module.spanner2.instance_id
#  project = var.project
#  database = "db1"
#  ddl = data.external.ddl.result
#  kms_key_name = ""
#  deletion_protection = false
# 
#}


#data "external" "ddl" {
#  program = ["cat", "scripts/ddl-file.txt"]
# }




module cloudrun {
  source = "./regional_deployment/cloudrun"
  name = "cloudrun-test"
  image = "gcr.io/clean-beaker-343108/cats"
  location = "asia-northeast3"
  project = var.project
  env = [{key = "secret", value = "db1", secret = "secret", version = "latest"}]
}

*/

module cloudrun {
  source = "./regional_deployment/cloudrun"
  name = "cloudrun-test"
  image = "gcr.io/clean-beaker-343108/cats"
  location = "asia-northeast3"
  project = var.project
  ingress =  "internal"
#binary-auth = "projects//platforms/cloudRun/policies/ENABLE"
#  vpc_connector_name = "cdps-vpc-connector-ae2-kr"
#  binary-auth = "default"
  env = [{name = "environment", value = "dev"}] 
  env_secret = [{name = "envir", secret = "secret", version = "latest"}]
  maxscale = 3
  minscale = 1
  

}
resource "google_compute_region_network_endpoint_group" "cloudrun_neg" {
  name                  = "cloudrun-neg"
  network_endpoint_type = "SERVERLESS"
  region                = "us-central1"
  cloud_run {
    service = "${module.cloudrun.name}"
  }
}


resource "google_compute_forwarding_rule" "default" {
#  provider              = google-beta
  name                  = "glb-test"
  region                = "us-central1"
  backend_service       = google_compute_region_network_endpoint_group.cloudrun_neg.id
}

