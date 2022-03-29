instance_name		= "spanner-test-instance"
project			= "My Project 90578"
config				= "regional-europe-west1"
display_name		= "tf-spanner-test-instance"
databases	= [
    { 
      name = "database-test-1",
      ddl = [
        "CREATE TABLE t1 (t1 INT64 NOT NULL,) PRIMARY KEY(t1)"
        ]
    },
    { 
      name = "database-test-2",
    },
  ]
}
