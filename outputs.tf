# Output file
output "eip" {
  value = aws_eip.primary.public_ip
}
