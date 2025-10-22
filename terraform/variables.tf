variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID para Ubuntu 22.04"
  type        = string
  default     = "ami-0c7217cdde317cfec" # Ubuntu 22.04 LTS em us-east-1
}

variable "ssh_public_key_path" {
  description = "Path para chave SSH pública"
  type        = string
  default     = "~/.ssh/taskflow-key.pub"
}