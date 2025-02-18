# Define the provider
provider "aws" {
  region = "ap-south-1"
}

# Define a list of instance names
variable "instance_names" {
  type    = list(string)
  default = ["web-server-1", "web-server-2", "web-server-3"]
}

# Define the EC2 instances using for_each
resource "aws_instance" "ec2_instances" {
  for_each = length(var.instance_names) # Convert list to set for iteration

  ami           = "ami-04b4f1a9cf54c11d0" # Example AMI for Amazon Linux 2 (Change as needed)
  instance_type = "t2.small"

  tags = {
    Name = each.value
  }
}

# Output the instance details
output "instance_ips" {
  value = { for k, v in aws_instance.ec2_instances : k => v.public_ip }
}
