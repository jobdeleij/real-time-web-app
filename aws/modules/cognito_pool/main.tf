resource "aws_cognito_user_pool" "user_pool" {
  name = var.pool_name
  auto_verified_attributes = ["email"]

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  email_configuration {
    configuration_set = var.email_configuration_set
    email_sending_account = "DEVELOPER"
    from_email_address = var.from_email_address
    source_arn = var.email_identity_arn
  }

  password_policy {
    minimum_length = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }
}