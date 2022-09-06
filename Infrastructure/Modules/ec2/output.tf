output "instance_id" {
    description = "The instance ID"
    value       = aws_instance.tf_instance.*.id
}

output "instance_public_ip" {
    description = "The Public IP of the instance"
    value       = aws_instance.tf_instance.*.public_ip
}

output "instance_public_dns" {
    description = "The Public DNS of the instance"
    value       = aws_instance.tf_instance.*.public_dns
}

output "instance_private_ip" {
    description = "The Private IP of the instance"
    value       = aws_instance.tf_instance.*.private_ip
}

output "instance_subnet" {
    description = "The subnet ID in which the instance resides"
    value       = aws_instance.tf_instance.*.subnet_id
}