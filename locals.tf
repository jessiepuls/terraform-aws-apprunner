locals {
  hosted_zone  = var.custom_domain_config == null ? null : var.custom_domain_config["hosted_zone"]
  domain_names = var.custom_domain_config == null ? [] : var.custom_domain_config["domain_names"]
  app_runner_validation_records = flatten([
    for domain, config in aws_apprunner_custom_domain_association.custom_domains : [
        config.certificate_validation_records
    ]
  ])
}