data "aws_iam_policy_document" "ec2_assumerole" {
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "backup_s3_access" {
  statement {
    resources = ["${aws_s3_bucket.backup.arn}"]

    actions = [
      "s3:ListBucket"
    ]
  }
  statement {
    resources = ["${aws_s3_bucket.backup.arn}/*"]

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:PutObjectVersionTagging",
      "s3:PutObjectTagging",
    ]
  }
}

resource "aws_iam_policy" "backup_s3_access" {
  name        = "tf-${var.project_name}-backup-${var.env}"
  description = "Terraform Managed. Allows ${var.project_name} EC2 to access S3."
  policy      = data.aws_iam_policy_document.backup_s3_access.json
}

resource "aws_iam_role_policy_attachment" "backup_s3_access" {
  role       = aws_iam_role.primary.name
  policy_arn = aws_iam_policy.backup_s3_access.arn
}

resource "aws_iam_role" "primary" {
  name               = "tf-${var.project_name}-${var.env}"
  description        = "Terraform Managed. Allows ${var.project_name} EC2 to access S3."
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.ec2_assumerole.json
}

resource "aws_iam_instance_profile" "primary" {
  name = "tf-${var.project_name}-${var.env}"
  role = aws_iam_role.primary.name
}
