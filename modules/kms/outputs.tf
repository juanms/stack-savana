output "key_arn" {
  description = "ARN of the KMS key"
  value       = aws_kms_key.main.arn
}

output "key_id" {
  description = "ID of the KMS key"
  value       = aws_kms_key.main.key_id
}

output "policy_arn" {
  description = "ARN of the KMS policy"
  value       = aws_iam_policy.kms_policy.arn
}