locals {
  ami_id = "ami-0b09ffb6d8b58ca91"
  instance_type = "t2.large"
  name = "${var.project}-${var.environment}-${var.component}-changed"

  key_name = data.aws_key_pair.existing_key.key_name
}
