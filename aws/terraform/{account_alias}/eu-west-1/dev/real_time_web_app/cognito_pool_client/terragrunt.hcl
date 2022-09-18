locals {
    account_vars   = read_terragrunt_config(find_in_parent_folders("account.hcl"))
    project_vars   = read_terragrunt_config(find_in_parent_folders("project.hcl"))
    aws_account_id = local.account_vars.locals.aws_account_id
}

terraform {
    source = "../../../../../../modules/cognito_pool_client"
}

include {
    path = find_in_parent_folders()
}

dependency "cognito-pool"  {
    config_path = "../cognito_pool"
    mock_outputs = {
        id = "id"
    }
}

inputs = {
  client_name                           = "${local.project_vars.locals.project_name}-client"
  pool_id                               = dependency.cognito-pool.outputs.id
  callback_urls                         = ["http://localhost"]
  allowed_oauth_flows_user_pool_client  = true
  oauth_flows                           = ["code", "implicit"]
  oauth_scopes                          = ["email", "openid"]
  generate_secret                       = false
}