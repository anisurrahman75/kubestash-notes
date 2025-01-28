```bash
[ec2-user@ip-172-31-4-105 ~]$ aws configure list
    Name                    Value             Type    Location
    ----                    -----             ----    --------
   profile                <not set>             None    None
access_key     ****************TG5K         iam-role    
secret_key     ****************uMjN         iam-role 
```

## Instance Metadata Service:

### Retrieve security credentials from instance metadata:

#### Link: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-metadata-security-credentials.html

```bash
[ec2-user@ip-172-31-4-105 ~]$ curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"
AQAEADah3-N_UNfklcbYpiUismAM1GgzZWCLiFpjIwE1Y5Oq5jqqkQ==

[ec2-user@ip-172-31-4-105 ~]$ curl -H "X-aws-ec2-metadata-token:AQAEADah3-N_UNfklcbYpiUismAM1GgzZWCLiFpjIwE1Y5Oq5jqqkQ==" http://169.254.169.254/latest/meta-data/iam/security-credentials/ec2-test


{
  "Code" : "Success",
  "LastUpdated" : "2025-01-13T09:35:06Z",
  "Type" : "AWS-HMAC",
  "AccessKeyId" : "ASIAWTLV67ZGKV52TG5K",
  "SecretAccessKey" : "",
  "Token" : "",
  "Expiration" : "2025-01-13T15:49:09Z"
}
```

