output "arn" {
    value = aws_cognito_user_pool.user_pool.arn
}

output "custom_domain" {
    value = aws_cognito_user_pool.user_pool.custom_domain
}

output "domain" {
    value = aws_cognito_user_pool.user_pool.domain
}

output "endpoint" {
    value = aws_cognito_user_pool.user_pool.endpoint
}

output "id" {
    value = aws_cognito_user_pool.user_pool.id
}