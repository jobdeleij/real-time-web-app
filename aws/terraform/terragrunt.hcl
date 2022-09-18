locals {
  global_vars = read_terragrunt_config(find_in_parent_folders("global.hcl"))
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  
  account_name       = local.account_vars.locals.account_name
  account_id         = local.account_vars.locals.aws_account_id
  account_alias_name = local.account_vars.locals.account_alias_name
  aws_region         = local.region_vars.locals.aws_region
  global_name        = local.global_vars.locals.global_name
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region                   = "${local.aws_region}"
  allowed_account_ids      = ["${local.account_id}"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "{profile_name}"
}
EOF
}

inputs = merge(
  local.account_vars.locals,
  local.region_vars.locals,
  local.global_vars.locals
)