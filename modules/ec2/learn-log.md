## ec2 
__last update__ - oct 26, 2026 

#### what did i learn 
- how does ec2 work in aws
- deploying an ec2 instance (using ui and tf) 
- why should i use terraform modules, even in smaller scale projects 
- basic aws networking 
  - when to use the security group and how, and how to increase code modularity
  - there is a default vpc that is attached to the ec2's sg, and there is inbound and outbound traffic
- added a combined iam role 
  - that allows to pass the module a list of iam profiles we want to add to the ec2
  - and it combines them into a final profile that also includes ssm 

#### related resources 

#### what this module might need in the future 
- expand variables to allow more flexibility when creating the ec2 instance 
  - additional storage devices, types, sizes 
  - monitoring
  - other operating systems support
  - change the user_data into base64 (when relevant) 
