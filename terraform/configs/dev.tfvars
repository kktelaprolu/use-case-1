instance_name		= "spanner-test-instance"
project			= "clean-beaker-343108"
config				= "regional-europe-west1"
display_name		= "tf-spanner-test-instance"
num_nodes		= 1
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
      ddl = [
        "CREATE TABLE t2 (t2 INT64 NOT NULL,) PRIMARY KEY(t2)"
        ]
     kms_key_name = ""
    },
    { 
      name = "database-test-3",
      ddl = []
      kms_key_name = ""
    },
  ]
