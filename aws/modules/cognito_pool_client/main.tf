resource "aws_cognito_user_pool_client" "this" {
  name                                 = var.client_name
  user_pool_id                         = var.pool_id
  callback_urls                        = var.callback_urls
  allowed_oauth_flows_user_pool_client = var.allowed_oauth_flows_user_pool_client
  allowed_oauth_flows                  = var.oauth_flows
  allowed_oauth_scopes                 = var.oauth_scopes
  supported_identity_providers         = var.supported_identity_providers
  generate_secret                      = var.generate_secret
}