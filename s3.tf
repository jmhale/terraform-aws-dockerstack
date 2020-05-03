resource "aws_s3_bucket" "backup" {
  bucket = "${data.aws_iam_account_alias.current.account_alias}-${var.project_name}-backup"
}
