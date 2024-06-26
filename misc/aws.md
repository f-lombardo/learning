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

## Steps to get the public key of a Cognito User Pool
1. get a JWT id Token (we put here in token var) connecting to the user pool userPoolUrl
2. decode the JWT token using any tool, for example https://jwt.io
3. from step 2 find the kid
4. get the list of JSON Web Keys (JWK) for the user pool connecting to
https://cognito-idp.{region}.amazonaws.com/{userPoolId}/.well-known/jwks.json
5. get the right key from the json you downloaded in step 4, for example
```
{
  "alg": "RS256",
  "e": "AQAB",
  "kid": "EQBIefxxxxxxxxxxxxxxxufgs=",
  "kty": "RSA",
  "n": "2TMkJbaSbIIRBjii7AvKOsyxxxxxxxxxxxxxxxxxxxxxxrf1J",
  "use": "sig"
}
```
6. Decode this JWK  to a PEM file using for example an online decoder like https://8gwifi.org/jwkconvertfunctions.jsp

## A script to update an ingres security group with your current IP

See [this script](./update_sg.sh)

## How to copy a file from/to S3
```
aws s3 cp s3://bucket-name/path/file .
```