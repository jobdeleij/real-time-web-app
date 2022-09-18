output "client_secret" {
    value = aws_cognito_user_pool_client.this.client_secret
    sensitive = true
}

output "id" {
    value = aws_cognito_user_pool_client.this.id
}