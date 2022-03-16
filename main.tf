resource "aws_apprunner_service" "apprunner_service" {
  service_name = var.service_name

  source_configuration {
    image_repository {
      image_configuration {
        port = var.port
        runtime_environment_variables = var.env_vars
      }
      
      image_identifier = var.image_identifier
      image_repository_type = var.image_repository_type
    }

    authentication_configuration {
      access_role_arn = var.ecr_access_role_arn
    }
  }

  tags = {
    Name = var.service_name
  }
}

resource "aws_apprunner_custom_domain_association" "custom_domains" {
  for_each    = local.domain_names
  domain_name = each.value
  service_arn = aws_apprunner_service.apprunner_service.arn
}