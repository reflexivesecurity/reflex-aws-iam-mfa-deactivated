module "iam_mfa_deactivated" {
  source           = "git::https://github.com/cloudmitigator/reflex-engine.git//modules/cwe_lambda?ref=v0.5.7"
  rule_name        = "IamMfaDeactivated"
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

  function_name   = "IamMfaDeactivated"
  source_code_dir = "${path.module}/source"
  handler         = "iam_mfa_deactivated.lambda_handler"
  lambda_runtime  = "python3.7"
  environment_variable_map = {
    SNS_TOPIC = var.sns_topic_arn
  }

  queue_name    = "IamMfaDeactivated"
  delay_seconds = 0

  target_id = "IamMfaDeactivated"

  sns_topic_arn  = var.sns_topic_arn
  sqs_kms_key_id = var.reflex_kms_key_id
}
