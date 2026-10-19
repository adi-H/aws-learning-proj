resource "aws_security_group" "sg" {
  name = var.sg_name


  # outbound traffic 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "vm" {

  ami           = local.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  iam_instance_profile = var.instance_profile_name

  user_data = var.user_data

  tags = merge(
    var.tags,
    {
      Name = var.vm_name
    }
  )

  # passing the name of the basic sg group i created above so i can export and add others if needed 
  vpc_security_group_ids = [aws_security_group.sg.id]


  # for now i am using basic root block device and later will add more functionality
  # the base linux ami has a root device of 8gb
  root_block_device {
    volume_size           = 8
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

}
