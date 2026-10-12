output "instance_id" {
  value = aws_instance.web.id
}

output "elastic_ip" {
  value = aws_eip.web_eip.public_ip
}
