variable "instance_name" {
  description	= "A unique identifier for the instance"
  type			= string
  default		= ""
}

variable "config" {
  description	= "The name of the instance's configuration which defines the geographic placement and replication of your databases in this instance"
  type			= string
}


variable "display_name" {
  description	= "The descriptive name for this instance"
  type			= string
}


variable "num_nodes" {
  description	= "The number of nodes allocated to this instance"
  type			= string
  default		= ""
}



variable "processing_units" {
  description	= "The number of processing units allocated to this instance."
  type			= string
  default		= ""
}


variable "project" {
  description	= "The ID of the project in which the resource belongs."
  type			= string
}


variable "force_destroy" {
  description	= "When deleting a spanner instance, this boolean option will delete all backups of this instance."
  type			= bool
  default		= true
}


variable "labels" {
  description	= "An object containing a list of key: value pairs."
  type			= map(string)
  default		= {}
}



variable "databases" {
  description	= " A unique identifier for the database,which cannot be changed after the instance is created. Values are of the form [a-z][-a-z0-9]*[a-z0-9]."
  type			= list(object({
      name = string,
      ddl = list(string),
      kms_key_name = string
    }
   )
  )
 default	= []
}


