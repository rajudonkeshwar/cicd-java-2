
data "aws_vpc" "default" {
  default = true
}

data "aws_key_pair" "existing_key" {
  key_name           = "word-press" # Replace with the actual name of your key pair
  include_public_key = true
}

output "default_vpc_id" {
    value = data.aws_vpc.default.id
}

