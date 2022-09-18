locals {
    account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
    aws_account_id = local.account_vars.locals.aws_account_id
    domain = local.account_vars.locals.main_domain
}

terraform {
    source = "../../../../../../../modules/ses_domain"
}

include {
    path = find_in_parent_folders()
}

inputs = {
  domain = local.domain
}