variable "vpc_cidr" {
  type        = string
  description = "The IP range for the entire VPC"
}

variable "public_1_subnet" {
  type = object({
    cidr_block = string
  })
}

variable "public_2_subnet" {
  type = object({
    cidr_block = string
  })
}

variable "private_subnet" {
  type = object({
    cidr_block = string
  })
}

variable "environment" {
  type        = string
  description = "Prefix for naming resources (e.g., dev, prod, learning)"
}
