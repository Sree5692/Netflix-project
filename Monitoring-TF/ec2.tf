resource "aws_instance" "ec2" {
  ami                    = data.aws_ami.ami.image_id
  instance_type          = "t2.medium"
  key_name               = var.key-name
  subnet_id              = aws_subnet.public-subnet3.id
  security_group_ids = [data.aws_security_group.sg-default.id]
  iam_instance_profile   = aws_iam_instance_profile.instance-profile.name
  root_block_device {
    volume_size = 30
  }
  user_data = templatefile("./monitor-install.sh", {})

  tags = {
    Name = var.instance-name
  }
}
