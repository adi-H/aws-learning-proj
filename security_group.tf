# resource "aws_security_group" "ec2-inbound-sg" {
#   name = "allow-ssh-http"
#   description = "allow basic ssh and http inbound traffic"
#   # omitting the vpcid to deploy to default 


#   # inbound 

#   # ssh (22) [best practice is to have this restricted but for this exercise purposes im not restricting]
#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"] 
#   }

#   # http (80)
#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"] 
#   }

#   # outbound 
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

# }