# About AWS services

## How to detect if a script is running on an EC2 instance

We should try to connect to the special address `169.254.169.254` (belonging to the special [IPV4 Link Local Address space](https://en.wikipedia.org/wiki/Link-local_address)) that holds [instance metadata for EC2 instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instancedata-data-retrieval.html).

```shell script
if curl --connect-timeout 1 http://169.254.169.254 > /dev/null 2> /dev/null
then
  export EXECUTION_ENVIRONMENT=aws
else
  export EXECUTION_ENVIRONMENT=local
fi
```

## How to create key-par for connecting to an EC2 instance through SSH
```shell script
ssh-keygen -m PEM -t rsa -C mysefl@mydomain.com
```

# AWS Services
* [Infrastructure as code](https://jennapederson.com/blog/2021/4/2/what-is-infrastructure-as-code/)
* [CloudFormation](https://jennapederson.com/blog/2021/5/10/introduction-to-aws-cloudformation/)
* DynamoDB:  
  * [What is DynamoDB](https://www.dynamodbguide.com/what-is-dynamo-db)
  * [Single-Table Design](https://www.alexdebrie.com/posts/dynamodb-single-table/)
