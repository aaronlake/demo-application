## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.2.0 |
| <a name="requirement_hcp"></a> [hcp](#requirement\_hcp) | ~> 0.22.0 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | 3.3.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_amazon-ami"></a> [amazon-ami](#provider\_amazon-ami) | n/a |
| <a name="provider_hcp"></a> [hcp](#provider\_hcp) | ~> 0.22.0 |
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ec2"></a> [ec2](#module\_ec2) | ./ec2 | n/a |
| <a name="module_rds"></a> [rds](#module\_rds) | app.terraform.io/Unicorp/rds/aws | 1.0.1 |

## Resources

| Name | Type |
|------|------|
| [amazon-ami_amazon-ami.ubuntu-focal-east](https://registry.terraform.io/providers/hashicorp/amazon-ami/latest/docs/data-sources/amazon-ami) | data source |
| [hcp_packer_image.webapp](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/data-sources/packer_image) | data source |
| [hcp_packer_iteration.webapp](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/data-sources/packer_iteration) | data source |
| [tfe_outputs.infrastructure](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/outputs) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | Environment (dev, qa, test, prod) | `string` | n/a | yes |
| <a name="input_hcp_client_id"></a> [hcp\_client\_id](#input\_hcp\_client\_id) | The HCP client ID | `string` | n/a | yes |
| <a name="input_hcp_client_secret"></a> [hcp\_client\_secret](#input\_hcp\_client\_secret) | The HCP client secret | `string` | n/a | yes |
| <a name="input_master_password"></a> [master\_password](#input\_master\_password) | The master password for the DB instance. | `string` | n/a | yes |
| <a name="input_master_username"></a> [master\_username](#input\_master\_username) | The master username for the DB instance. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_version"></a> [version](#input\_version) | n/a | `string` | `"1.0.0"` | no |

## Outputs

No outputs.
