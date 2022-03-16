locals {
  image_name   = "your-image-name"
  environment = "staging"
  ecr_repo_url = "your-ecr-repo-url" # I'd tend to make this in a separate module because it's being used in multiple environments
}

module "app_runner" {
    # make this path match your path to the module
    source = "../../modules/app_runner"

    # in staging we deploy the latest tag. 
    # The staging build pipeline updates latest each time a new image is pushed.
    image_identifier = "${local.ecr_repo_url}:latest"
    service_name = "${local.environment}-${local.image_name}"

    # make this at the same time as you make the repo
    ecr_access_role_arn = "role-with-ecr-read-access" 

    port = 3000
    env_vars = {
      RAILS_ENV = "staging"
    }

    custom_domain_config = {
      hosted_zone = "your-hosted-zone" # chances are this is maintained separately. If it's managed in terraform you can pull it in from a remote state. Otherwise just hardcode it.
      domain_names = ["url-for-this-app"]
    }
}