locals {
  account_name       = "Example"
  aws_account_id     = "012345678901"
  account_alias_name = "example"
  main_domain        = "example.nl"
  no_reply_email     = "noreply@${local.main_domain}"
}
