## ec2 
__last update__ - nov 25, 2026 

#### what did i learn 
- how does ec2 work in aws
- deploying an ec2 instance (using ui and tf) 
- why should i use terraform modules, even in smaller scale projects 
- basic aws networking 
  - when to use the security group and how, and how to increase code modularity
    - the sg is defined empty, and each rule is its own resource (`aws_vpc_security_group_ingress_rule` / `aws_vpc_security_group_egress_rule`), so other modules can add rules to it - based on [this reddit thread](https://www.reddit.com/r/aws/comments/puoty4/aws_terraform_how_do_you_manage_your_security/)
  - every region has a default vpc, which is used when no vpc is specified, and a security group controls the inbound and outbound traffic of the instance
  - an instance can have more than one security group (`vpc_security_group_ids`) - the module's own sg plus the one passed in from the networking module
- `vpc_id` and `subnet_id` are optional - if they aren't passed, the module falls back to the default vpc and its first subnet
- added a combined iam role 
  - that allows passing the module a list of iam policy arns (`additional_policy_arns`) we want to add to the ec2
  - and it combines them into a final instance profile that also includes ssm (`AmazonSSMManagedInstanceCore`)
  - an instance can only have one instance profile, which is why the policies are combined into one role

#### related resources 
- [iam-role-and-policy](../iam-role-and-policy/learn-log.md) - provides the bucket access policy arn
- [networking](../networking/learn-log.md) - provides the vpc, private subnet and `app_sg`
- project logs: [sept 6](../../learn-logs/sep-06-26.md), [oct 20](../../learn-logs/oct-20-26.md), [oct 21-26](../../learn-logs/oct-26-26.md)

#### what this module might need in the future 
- expand variables to allow more flexibility when creating the ec2 instance 
  - additional storage devices, types, sizes 
  - monitoring
  - other operating systems support
  - change the user_data into base64 (when relevant) 
- remove the open ssh (port 22) rule, now that access is through ssm
