""" Module for detecting deactivation of MFA """

import json

from reflex_core import AWSRule


class IamMfaDeactivated(AWSRule):
    """ AWS rule for detecting MFA deactivation """

    def __init__(self, event):
        super().__init__(event)

    def extract_event_data(self, event):
        """ Extract required data from the event """
        self.user_name = event["detail"]["requestParameters"]["userName"]

    def resource_compliant(self):
        """ Determines if the resource is compliant. Returns True if compliant, False otherwise """
        # We simply want to know when this event occurs. Since this rule was
        # triggered we know that happened, and we want to alert. Therefore
        # the resource is never compliant.
        return False

    def get_remediation_message(self):
        """ Returns a message about the remediation action that occurred """
        return f"MFA was deactivated for {self.user_name}."


def lambda_handler(event, _):
    """ Handles the incoming event """
    rule = IamMfaDeactivated(json.loads(event["Records"][0]["body"]))
    rule.run_compliance_rule()
