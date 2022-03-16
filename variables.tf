variable "service_name" {
    description = "AppRunner Service Name"
    type = string
    validation {
        condition     = can(regex("^[0-9A-Za-z-]+$", var.service_name))
        error_message = "Service name my only contain alphanumeric characters and dash."
    }
}

variable "image_repository_type" {
    description = "Public/private ECR repo"
    type = string
    default = "ECR"
    
    validation {
        condition = contains(["ECR", "ECR_PUBLIC"], var.image_repository_type)
        error_message = "Allowed values for image_repository_type are \"ECR\", \"ECR_PUBLIC\"."
    }
}

variable "image_identifier" {
    description = "Name of the image to pull from the ecr repo."
    type = string
}

variable "ecr_access_role_arn" {
    description = "Role to be used to access ecr."
    type = string
}

variable "port" {
    description = "Port to expose on container that is deployed"
    type = number
}

variable "env_vars" {
    description = "Port to expose on container that is deployed"
    type = map
    default = {}
}

variable "custom_domain_config" {
    type = object({
        hosted_zone  = string
        domain_names = set(string)
    })
    description = "Custom domains to set up and configured for apprunner service."
    default = null
}