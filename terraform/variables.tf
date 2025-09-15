variable "instance_type" {
  type        = string
  default     = "t2.large"
  description = "description"
}

variable "project" {
    default = "k8s"
}

variable "component" {
    default = "frontend"
}

variable "environment" {
    default = "test"
}

