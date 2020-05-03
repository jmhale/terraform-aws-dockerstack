# Output file
output "streamstack_eip" {
  value = aws_eip.primary.public_ip
}
