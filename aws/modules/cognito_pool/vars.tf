variable "pool_name" {
    type = string
    description = "The name of the user pool"
}

variable "from_email_address" {
    type = string
    description = "The email address to send emails from"
}

variable "email_identity_arn" {
    type = string
    description = "The Amazon Resource Name (ARN) of the email identity"
}

variable "email_configuration_set" {
    type = string
    description = "The name of the email configuration set"
}