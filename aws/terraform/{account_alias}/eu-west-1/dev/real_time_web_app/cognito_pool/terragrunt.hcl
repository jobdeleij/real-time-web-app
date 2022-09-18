locals {
    account_vars   = read_terragrunt_config(find_in_parent_folders("account.hcl"))
    project_vars   = read_terragrunt_config(find_in_parent_folders("project.hcl"))
    aws_account_id = local.account_vars.locals.aws_account_id
}

terraform {
    source = "../../../../../../modules/cognito_pool"
}

include {
    path = find_in_parent_folders()
}

dependency "noreply-deleijdevelopment-email-identity"  {
    config_path = "../../../shared/ses/email_identity/noreply"
    mock_outputs = {
        arn = "arn"
    }
}

dependency "default-email-configuration-set"  {
    config_path = "../../../shared/ses/email_configuration_set/default"
    mock_outputs = {
        arn = "arn"
    }
}

inputs = {
  pool_name               = "${local.project_vars.locals.project_name}-pool"
  from_email_address      = local.account_vars.locals.no_reply_email
  email_identity_arn      = dependency.noreply-deleijdevelopment-email-identity.outputs.arn
  email_configuration_set = dependency.default-email-configuration-set.outputs.id
}