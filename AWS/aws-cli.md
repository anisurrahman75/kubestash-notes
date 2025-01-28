## Create ECS Instance


## Add Iam Role to EC2
```bash
$ aws ec2 associate-iam-instance-profile \
          --instance-id i-07fb946428eb95ae7 \
          --iam-instance-profile Name=ec2-test --region=us-west-1
```

## List Instances
```bash
$ aws ec2 describe-instances --query "Reservations[*].Instances[*].[InstanceId,State.Name,Tags[?Key=='Name'].Value|[0]]" --output table --region=us-west-1
```

## Terminate an Instance
```bash
$ aws ec2 terminate-instances --instance-ids i-0abcd1234efgh5678 --region=us-west-1 
```

## Check Status
```bash
$ aws ec2 describe-instances --instance-ids i-0abcd1234efgh5678 --query "Reservations[*].Instances[*].State.Name" --region=us-west-1 --output text
```

