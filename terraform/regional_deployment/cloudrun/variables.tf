variable "name"  {
  description = "Name must be unique within a namespace, within a Cloud Run region."
  type        = string
}


variable "location"  {
  description = "The location of the cloud run instance."
  type        = string
}


variable "image"  {
  description = "The image to be deployed on cloud run instance."
  type        = string
}

variable "container_concurrency"  {
  description = "Maximum allowed concurrent requests per container for this revision."
  type = number
  default = null
}


variable "timeout"  {
  description = "TimeoutSeconds holds the max duration(seconds)the instance is allowed for responding to a request"
  type = number
  default = 60
}


variable "service_account_name"  {
  description = "Email address of the IAM service account associated with the revision of the service."
  type = string
  default = null
}

variable "http2" {
  description = "Enable use of HTTP/2 end-to-end."
  type = bool
  default = false
}

variable "port" {
  description = "Port number the container listens on. This must be a valid port number, 0 < x < 65536."
  type = number
  default = 8080
}


variable "cpus" {
  description = "Number of CPUs to allocate per container."
  type = number
  default = 1
}


variable "memory" {
  description = "Memory (in Mi) to allocate to containers."
  type = number
  default = 256
}

variable "labels" {
  type = map(string)
  default = {}
  description = "Labels to apply to the service."
}

variable "project" {
  type = string
  default = null
  description = "Project id in which to create resources."
}


variable "revision" {
  type = string
  default = null
  description = "Revision name to use. When `null`, revision names are automatically generated."
}


variable "env" {
  type = list(
    object({
      key = string,
      value = string,
      secret = string,
      version = string
    })
  )
  default = []
/*
  validation {
    error_message = "Environment variables must have one of `value` or `secret` defined."
    condition = alltrue([
      length([for e in var.env: e if (e.value == null && e.secret == null)]) < 1,
      length([for e in var.env: e if (e.value != null && e.secret != null)]) < 1,
    ])
  }
*/
}

