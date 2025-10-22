output "instance_public_ip" {
  description = "IP público da instância EC2"
  value       = aws_instance.taskflow_server.public_ip
}

output "instance_id" {
  description = "ID da instância EC2"
  value       = aws_instance.taskflow_server.id
}

output "ssh_connection" {
  description = "Comando SSH para conectar"
  value       = "ssh -i ~/.ssh/taskflow-key ubuntu@${aws_instance.taskflow_server.public_ip}"
}