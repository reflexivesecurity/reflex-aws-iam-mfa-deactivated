module "cwe" {
  source      = "git::https://github.com/cloudmitigator/reflex-engine.git//modules/cwe?ref=v0.6.0"
  name        = "IamMfaDeactivated"
  description = "Rule to check when MFA Devices are Deactivated"

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

}
