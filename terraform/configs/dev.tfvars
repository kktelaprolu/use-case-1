instance_name		= "spanner-test-instance"
project			= "civil-keyword-345118"
config				= "regional-europe-west1"
display_name		= "tf-spanner-test-instance"
num_nodes		= 1
databases	= [
    { 
      name = "database-test-1",
      ddl = [
        "CREATE TABLE t1 (t1 INT64 NOT NULL,) PRIMARY KEY(t1)"
        ]
    }
  ]
