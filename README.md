# reflex-aws-detect-deactivate-mfa
A Reflex rule for detecting the deactivation of an MFA device for an IAM user.

## Usage
To use this rule either add it to your `reflex.yaml` configuration file:  
```
version: 0.1

providers:
  - aws

measures:
  - reflex-aws-detect-deactivate-mfa
```

or add it directly to your Terraform:  
```
...

module "enforce-s3-encryption" {
  source           = "github.com/cloudmitigator/reflex-aws-detect-deactivate-mfa"
  email            = "example@example.com"
}

...
```

## License
This Reflex rule is made available under the MPL 2.0 license. For more information view the [LICENSE](https://github.com/cloudmitigator/reflex-aws-detect-deactivate-mfa/blob/master/LICENSE) 
