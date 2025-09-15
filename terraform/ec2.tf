resource "aws_instance" "this" {
  ami                    = local.ami_id
  vpc_security_group_ids = [aws_security_group.k8s.id]
  #instance_type          = var.instance_type
  user_data = file("practice.sh")
  instance_type = local.instance_type

  root_block_device {
  volume_size = 50
  volume_type = "gp3"
}



  tags = {
    # expense-dev-backend
    Name    = local.name
    Purpose = "terraform-practice"
  }

  key_name = local.key_name
}

resource "aws_security_group" "k8s" {
  name        = "k8s"
  description = "Allow TLS inbound traffic and all outbound traffic"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "k8s"
  }
}