variable "aws_region" {
  type = string
}


variable "ec2_instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Running EC2 instance"

}
variable "ec2_volume_config" {
  type = object({
    size = number
    type = string
  })
  default = {
    size = 10
    type = "gp3"
  }
}

variable "instance_class" {
  type        = string
  default     = "db.m5.large"
  description = "Running Aurora instance"

  validation {
    condition     = contains(["db.m5.large"], var.instance_class)
    error_message = <<-EOT
    This instance class must contain: 'db.m5.large'
    EOT
  }
}
variable "storage_size" {
  type        = number
  default     = 10
  description = "The amount of allocated for DB instance in GB"

  validation {
    condition     = var.storage_size >= 10 && var.storage_size <= 20
    error_message = <<-EOT
    The amount of allocated storage for Aurora DB must be 
    between 10 and 20 GB
    EOT
  }
}
variable "engine_version" {
  type        = string
  default     = "8.0"
  description = "The engine version of DB instance"

  validation {
    condition = contains(["8.0"], var.engine_version)
    error_message = <<-EOT
    This engine version must contain: '8.0'
    EOT
  
  }

  
}
variable "engine" {
  type        = string
  default     = "mysql"
  description = "The engine of DB instance"

  validation {
    condition     = contains(["mysql"], var.engine)
    error_message = <<-EOT
    This engine must contain: 'aurora-mysql'
    EOT
  }
}

variable "domain_name" {
  default     = "thezelvo.com" #register a domain name first 
  description = "domain name for route 53"
  type        = string

}

variable "record_name" {
  default     = "www"
  description = "sub domain name for route 53"
  type        = string
}