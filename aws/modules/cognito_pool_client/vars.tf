variable "client_name" {
    type = string
    description = "The name of the client"
}

variable "pool_id" {
    type = string
    description = "The ID of the user pool"
}

variable "callback_urls" {
    type = list(string)
    description = "The callback URLs for the client"
}

variable "allowed_oauth_flows_user_pool_client" {
    type = bool
    description = "Whether the user pool client is allowed to use the allowed OAuth flows"
}

variable "oauth_flows" {
    type = list(string)
    description = "The allowed OAuth flows for the client"
}

variable "oauth_scopes" {
    type = list(string)
    description = "The allowed OAuth scopes for the client"
}

variable "supported_identity_providers" {
    type = list(string)
    description = "The supported identity providers for the client"
    default = ["COGNITO"]
}

variable "generate_secret" {
    type = bool
    description = "Whether to generate a secret for the client"
}