resource "aws_ses_configuration_set" "this" {
  name = var.name

  delivery_options {
    tls_policy = "Require"
  }
}