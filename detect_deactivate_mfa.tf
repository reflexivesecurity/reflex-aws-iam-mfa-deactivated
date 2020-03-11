module "detect_deactivate_mfa" {
  source           = "git::https://github.com/cloudmitigator/reflex-engine.git//modules/cwe_sns_email?ref=v0.2.0"
  rule_name        = "DetectMFADeactivate"
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

  target_id  = "DetectDeactivateMFA"
  sns_topic_arn = var.sns_topic_arn
}
