# Terraform Module: AWS ec2

This module provisions a basic AWS ec2 instance. this comes with a basic private security group to allow incoming traffic


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.9 |
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
| [aws_instance.vm](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/resources/instance) | resource |
| [aws_security_group.sg](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/resources/security_group) | resource |
| [aws_ami.amazon_linux](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 instance type | `string` | `"t3.micro"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | SSH key pair name. Set to null to disable SSH key. | `string` | `null` | no |
| <a name="input_sg_name"></a> [sg\_name](#input\_sg\_name) | Name tag for the security-group instance | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags | `map(string)` | `{}` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | User data script to run on first boot (human readable, not base64 at this point) | `string` | `null` | no |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | Name tag for the EC2 instance | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | The ID of the EC2 instance |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | Private IP address of the instance |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | Public IP address (if assigned) |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | sg id of the ec2 instance |
<!-- END_TF_DOCS -->
