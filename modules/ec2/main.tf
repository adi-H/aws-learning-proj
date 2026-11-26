
resource "aws_security_group" "sg" {
  name        = var.sg_name
  description = "sg group for the ec2 instance"
  vpc_id      = data.aws_vpc.selected.id

  tags = {
    Name = var.sg_name
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.sg.id

  description = "allow all outbound traffic to the internet"
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}


resource "aws_instance" "vm" {
  #checkov:skip=CKV_AWS_126:detailed (1-minute) monitoring costs extra, the free 5-minute metrics are enough for now

  ami           = local.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  ebs_optimized = true # t3 instances are ebs-optimized by default, this makes it explicit

  # require IMDSv2 (session tokens) - blocks credential theft through the metadata service (e.g. via ssrf)
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  iam_instance_profile = aws_iam_instance_profile.final_profile.name

  user_data = var.user_data

  tags = merge(
    var.tags,
    {
      Name = var.vm_name
    }
  )

  # passing the name of the basic sg group i created above so i can export and add others if needed 
  vpc_security_group_ids = concat(
    [aws_security_group.sg.id],
    var.additional_security_group_ids
  )

  subnet_id = data.aws_subnet.selected.id

  # for now i am using basic root block device and later will add more functionality
  # the base linux ami has a root device of 8gb
  root_block_device {
    volume_size           = 8
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.ssm_core,
    aws_iam_role_policy_attachment.extra_policies,
  ]

}
