## networking
__last update__ - oct 26, 2026 

#### what did i learn 
- deploying different network (using ui and tf) 
- ALB requires at least 2 public subnets in 2 availability zones 
- lb objects and checking on the tree in aws console  
- the hierarchy of using network components 

| Component | Layer | Purpose | Terraform Resource |
| :--- | :--- | :--- | :--- |
| **Virtual Private Cloud (VPC)** | Core Network | Acts as an isolated, private virtual data center bubble inside AWS. | `aws_vpc` |
| **Internet Gateway (IGW)** | Edge Routing | Bridges the VPC network to the public internet for inbound/outbound traffic. | `aws_internet_gateway` |
| **Public Subnet** | Subnetwork | A dedicated zone inside an Availability Zone hosting public-facing resources. | `aws_subnet` |
| **Route Table & Association** | Subnetwork | Directs all subnet internet traffic (`0.0.0.0/0`) out through the IGW. | `aws_route_table` |
| **Security Group** | Firewall | Stateful firewall wrapping the EC2 network interface; restricts incoming ports. | `aws_security_group` |
| **EC2 Instance** | Compute | The virtual machine executing the web server software. | `aws_instance` |


#### related resources 

#### what this module might need in the future 
