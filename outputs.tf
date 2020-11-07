# Output file
output "eip" {
  value = aws_eip.primary.public_ip
}

output "internal_ip" {
  value = aws_instance.primary.private_ip
}