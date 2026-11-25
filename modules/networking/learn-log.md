## networking
__last update__ - nov 25, 2026 

#### what did i learn 
- deploying a custom network (using ui and tf) 
- ALB requires at least 2 public subnets in 2 availability zones 
- lb objects (load balancer -> listener -> target group -> targets) and checking on the resource tree in the aws console  
- a private subnet reaches the internet only through a NAT gateway placed in a public subnet
- testing the module with `terraform test` (`tests/networking.tftest.hcl`)
- the security groups are created empty and the rules are separate resources, the same pattern as the ec2 module (from [this reddit thread](https://www.reddit.com/r/aws/comments/puoty4/aws_terraform_how_do_you_manage_your_security/))
- the hierarchy of using network components 

| Component | Layer | Purpose | Terraform Resource |
| :--- | :--- | :--- | :--- |
| **Virtual Private Cloud (VPC)** | Core Network | Acts as an isolated, private virtual data center bubble inside AWS. | `aws_vpc` |
| **Internet Gateway (IGW)** | Edge Routing | Bridges the VPC network to the public internet for inbound/outbound traffic. | `aws_internet_gateway` |
| **Public Subnet** | Subnetwork | A dedicated zone inside an Availability Zone hosting public-facing resources (ALB, NAT gateway). | `aws_subnet` |
| **Private Subnet** | Subnetwork | A zone with no direct route from the internet, hosting the application servers. | `aws_subnet` |
| **NAT Gateway + Elastic IP** | Edge Routing | Lets resources in the private subnet start outbound connections to the internet, without allowing inbound ones. | `aws_nat_gateway`, `aws_eip` |
| **Public Route Table & Association** | Subnetwork | Directs the public subnets' internet traffic (`0.0.0.0/0`) out through the IGW. | `aws_route_table`, `aws_route_table_association` |
| **Private Route Table & Association** | Subnetwork | Directs the private subnet's internet traffic (`0.0.0.0/0`) out through the NAT gateway. | `aws_route_table`, `aws_route_table_association` |
| **Application Load Balancer (ALB)** | Load Balancing | Public entry point that receives HTTP traffic and forwards it to the private instances. | `aws_lb`, `aws_lb_listener` |
| **Target Group** | Load Balancing | The set of instances the ALB forwards to, with health checks on port 80. | `aws_lb_target_group` |
| **Security Group** | Firewall | Stateful firewall wrapping the network interface; `alb_sg` allows port 80 from the internet, `app_sg` allows port 80 only from `alb_sg`. | `aws_security_group` |
| **EC2 Instance** | Compute | The virtual machine executing the web server software. | `aws_instance` |


#### related resources 
- [ec2](../ec2/learn-log.md) - deployed into the private subnet with `app_sg`
- project log: [oct 21-26](../../learn-logs/oct-26-26.md) - includes the traffic flow diagrams

#### what this module might need in the future 
- private subnets (and a NAT gateway per AZ) in at least 2 availability zones, for high availability
- an HTTPS listener (port 443 with an ACM certificate)
- switch the security group rules from `aws_security_group_rule` to `aws_vpc_security_group_ingress_rule` / `aws_vpc_security_group_egress_rule`, like in the ec2 module
- a `versions.tf` file, like the other modules
