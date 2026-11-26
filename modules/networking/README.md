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
| [aws_default_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/resources/default_security_group) | resource |
| [aws_eip.nat](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/resources/eip) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/resources/internet_gateway) | resource |
| [aws_lb.external_alb](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/resources/lb) | resource |
| [aws_lb_listener.http](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.alb_tg](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/resources/lb_target_group) | resource |
| [aws_nat_gateway.nat](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/resources/nat_gateway) | resource |
| [aws_route_table.private_rt](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/resources/route_table) | resource |
| [aws_route_table.public_rt](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_1](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_2](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/resources/route_table_association) | resource |
| [aws_security_group.alb_sg](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/resources/security_group) | resource |
| [aws_security_group.app_sg](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/resources/security_group) | resource |
| [aws_security_group_rule.alb_allow_http](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.alb_egress_to_app](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.app_allow_all_egress](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.app_allow_from_alb](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/resources/security_group_rule) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/resources/subnet) | resource |
| [aws_subnet.public_1](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/resources/subnet) | resource |
| [aws_subnet.public_2](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/resources/vpc) | resource |
| [aws_availability_zones.zones](https://registry.terraform.io/providers/hashicorp/aws/6.61.0/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_environment"></a> [environment](#input\_environment) | Prefix for naming resources (e.g., dev, prod, learning) | `string` | n/a | yes |
| <a name="input_private_subnet"></a> [private\_subnet](#input\_private\_subnet) | n/a | <pre>object({<br/>    cidr_block = string<br/>  })</pre> | n/a | yes |
| <a name="input_public_1_subnet"></a> [public\_1\_subnet](#input\_public\_1\_subnet) | n/a | <pre>object({<br/>    cidr_block = string<br/>  })</pre> | n/a | yes |
| <a name="input_public_2_subnet"></a> [public\_2\_subnet](#input\_public\_2\_subnet) | n/a | <pre>object({<br/>    cidr_block = string<br/>  })</pre> | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | The IP range for the entire VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | n/a |
| <a name="output_app_sg_id"></a> [app\_sg\_id](#output\_app\_sg\_id) | n/a |
| <a name="output_private_subnet_id"></a> [private\_subnet\_id](#output\_private\_subnet\_id) | n/a |
| <a name="output_public_1_subnet_id"></a> [public\_1\_subnet\_id](#output\_public\_1\_subnet\_id) | n/a |
| <a name="output_public_2_subnet_id"></a> [public\_2\_subnet\_id](#output\_public\_2\_subnet\_id) | n/a |
| <a name="output_target_group_arn"></a> [target\_group\_arn](#output\_target\_group\_arn) | n/a |
| <a name="output_vpc_cidr"></a> [vpc\_cidr](#output\_vpc\_cidr) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
<!-- END_TF_DOCS -->