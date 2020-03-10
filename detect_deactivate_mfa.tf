module "detect_deactivate_mfa" {
  source           = "git@github.com:cloudmitigator/reflex.git//modules/cwe_lambda?ref=v0.5.1"
  rule_name        = "DetectDeactivateMFA"
  rule_description = "Rule to check when MFA Devices are Deactivated"

  event_pattern = <<PATTERN
{
  "detail-type": [
    "AWS API Call via CloudTrail"
  ],
  "source": [
    "aws.iam"
  ],
  "detail": {
    "eventSource": [
      "iam.amazonaws.com"
    ],
    "eventName": [
      "DeactivateMFADevice"
    ]
  }
}
PATTERN

  function_name   = "DetectDeactivateMFA"
  source_code_dir = "${path.module}/source"
  handler         = "deactivate_mfa.lambda_handler"
  lambda_runtime  = "python3.7"
  environment_variable_map = {
    SNS_TOPIC = var.sns_topic_arn
  }
  custom_lambda_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetEncryptionConfiguration",
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF



  queue_name    = "DetectDeactivateMFA"
  delay_seconds = 60

  target_id = "DetectDeactivateMFA"

  sns_topic_arn  = var.sns_topic_arn
  sqs_kms_key_id = var.reflex_kms_key_id
}
