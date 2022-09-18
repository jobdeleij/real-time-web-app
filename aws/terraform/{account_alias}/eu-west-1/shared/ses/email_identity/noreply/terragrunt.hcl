locals {
    account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
    aws_account_id = local.account_vars.locals.aws_account_id
}

terraform {
    source = "../../../../../../../modules/ses_email_identity"
}

include {
    path = find_in_parent_folders()
}


inputs = {
  email = local.account_vars.locals.no_reply_email
}