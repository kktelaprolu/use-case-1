variable "instance-name" {
  description	= "A unique identifier for the instance"
  type			= string
  default		= ""
}

variable "project" {
  description	= "The ID of the project in which the resource belongs."
  type			= string
}



variable "database" {
  description	= " A unique identifier for the database,which cannot be changed after the instance is created. Values are of the form [a-z][-a-z0-9]*[a-z0-9]."
  type			= string
  default	= ""
}

variable "deletion_protection" {
  description = ""
  type  = bool
  
}

variable "ddl" {
  description = ""
  type = list(string)
  default = []
}

variable "kms_key_name" {
  description = ""
  type = string
  default = ""

}
