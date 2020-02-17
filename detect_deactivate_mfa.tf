provider "aws" {
  region = "us-east-1"
}

module "detect_deactivate_mfa" {
  source           = "git@github.com:cloudmitigator/reflex.git//modules/cwe_sns_email?ref=v0.0.1"
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

  topic_name = "DetectDeactivateMFA"
  target_id  = "DetectDeactivateMFA"
  email      = var.email
}
