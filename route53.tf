data "aws_route53_zone" "rote53_zone" {
  count        = local.hosted_zone == null ? 0 : 1
  name         = local.hosted_zone
}

resource "aws_route53_record" "apprunner_custom_record" {
  for_each = local.domain_names
  zone_id  = data.aws_route53_zone.rote53_zone[0].zone_id
  name     = each.value
  type     = "CNAME"
  ttl      = "300"
  records  = [aws_apprunner_service.apprunner_service.service_url]
}

resource "aws_route53_record" "certificate_validation_records" {
  for_each = {for vr in local.app_runner_validation_records:  vr.value => vr}
  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.value]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.rote53_zone[0].zone_id
}