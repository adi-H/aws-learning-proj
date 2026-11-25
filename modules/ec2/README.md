# Terraform Module: AWS ec2

This module provisions a basic AWS ec2 instance. this comes with its own security group (outbound traffic only by default - extra groups can be attached with `additional_security_group_ids`), and access to the instance is through ssm


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 6.61.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.61.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [aws_iam_instance_profile.final_profile](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.combined_role](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.extra_policies](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ssm_core](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_instance.vm](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/resources/instance) | resource |
| [aws_security_group.sg](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.allow_all_outbound](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_ami.amazon_linux](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/data-sources/ami) | data source |
| [aws_subnet.selected](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/data-sources/subnet) | data source |
| [aws_subnets.fallback](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/data-sources/subnets) | data source |
| [aws_vpc.selected](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_additional_policy_arns"></a> [additional\_policy\_arns](#input\_additional\_policy\_arns) | A list of extra IAM policy ARNs to attach to the EC2 instance | `list(string)` | `[]` | no |
| <a name="input_additional_security_group_ids"></a> [additional\_security\_group\_ids](#input\_additional\_security\_group\_ids) | Extra security group IDs to attach to the instance, on top of the module's own sg | `list(string)` | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | the env name | `string` | `"test"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 instance type | `string` | `"t3.micro"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | SSH key pair name. Set to null to disable SSH key. | `string` | `null` | no |
| <a name="input_sg_name"></a> [sg\_name](#input\_sg\_name) | Name tag for the security-group instance | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the Subnet where the EC2 instance will be deployed | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags | `map(string)` | `{}` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | User data script to run on first boot (human readable, not base64 at this point) | `string` | `null` | no |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | Name tag for the EC2 instance | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC where the Security Group will be created | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | The ID of the EC2 instance |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | Private IP address of the instance |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | Public IP address (if assigned) |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | sg id of the ec2 instance |
<!-- END_TF_DOCS -->
