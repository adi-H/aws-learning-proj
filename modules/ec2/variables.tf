
variable "vm_name" {
  description = "Name tag for the EC2 instance"
  type        = string
}
variable "sg_name" {
  description = "Name tag for the security-group instance"
  type        = string
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where the Security Group will be created"
  default     = null
}

variable "subnet_id" {
  type        = string
  description = "The ID of the Subnet where the EC2 instance will be deployed"
  default     = null
}

variable "environment" {
  description = "the env name"
  type        = string
  default     = "test"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "SSH key pair name. Set to null to disable SSH key."
  type        = string
  default     = null
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}

variable "user_data" {
  description = "User data script to run on first boot (human readable, not base64 at this point)"
  type        = string
  default     = null
}

variable "additional_policy_arns" {
  type        = list(string)
  default     = []
  description = "A list of extra IAM policy ARNs to attach to the EC2 instance"
}

variable "networking_security_group_id" {
  type = string
}
