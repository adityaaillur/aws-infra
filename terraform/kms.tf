data "aws_caller_identity" "current" {}

resource "aws_kms_key" "ebs-kms" {
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          "AWS" : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action = [
          "kms:*"
        ],
        Resource = "*",
      },
      {
        Effect = "Allow",
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ],
        Resource = "*",
        Principal = {
          "AWS" : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
        }
      },
      {
        Effect = "Allow",
        Action = [
          "kms:CreateGrant"
        ],
        Resource = "*",
        Principal = {
          "AWS" : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
        }
        Condition = {
          Bool : {
            "kms:GrantIsForAWSResource" : true
          }
        }
      }
    ]
  })
}

resource "aws_kms_alias" "ebs-kms" {
  name          = "alias/ebs-kms"
  target_key_id = aws_kms_key.ebs-kms.key_id
}

resource "aws_kms_key" "rds_encryption_key" {
  deletion_window_in_days = 7

}

resource "aws_kms_alias" "rds-kms" {
  name          = "alias/rds-kms"
  target_key_id = aws_kms_key.rds_encryption_key.key_id
}