# Output file
output "eip" {
  value = aws_eip.primary.public_ip
}

output "internal_ip" {
  value = aws_instance.primary.private_ip
}

output "backup_s3_bucket" {
  value = aws_s3_bucket.backup.bucket
}