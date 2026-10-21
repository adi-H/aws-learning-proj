variable "vpc_cidr" {
  type        = string
  description = "The IP range for the entire VPC"
}

variable "public_subnet_cidr" {
  type        = string
  description = "The IP range for the public subnet"
}

variable "environment" {
  type        = string
  description = "Prefix for naming resources (e.g., dev, prod, learning)"
}
