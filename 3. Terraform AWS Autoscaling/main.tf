#############################################################################
# WHICH PROVIDER.  AND REGION
#############################################################################
provider "aws" {
  region        = "us-west-2"
  access_key    = "XXXIAUXXXXXXXXXXXXXXX"
  secret_key    = "XXXvsCXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

#############################################################################
# DNS ALB
############################################################################

output "alb_dns_name" {
  value       = aws_lb.alb.dns_name
  description = "ALB Domain name"
}
