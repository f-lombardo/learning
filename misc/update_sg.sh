#!/bin/bash

RULE_NAME=$(logname)
PROFILE=xxxxxxxxxx
PORT=22
SG=sg-00000000000000000

OLD_CDIR=$(aws ec2 describe-security-groups --group-ids $SG --profile $PROFILE --output text | grep "$RULE_NAME" | awk '{print $2}')

if [[ -z "$OLD_CDIR" ]]; then
    echo "No previous CIDR set"
else
    echo "Deleting $OLD_CDIR"
    aws ec2 revoke-security-group-ingress \
        --group-id $SG \
        --profile $PROFILE \
        --protocol tcp \
        --port $PORT \
        --cidr $OLD_CDIR
fi

CURRENT_IP=$(curl -s http://whatismyip.akamai.com/)

aws ec2 authorize-security-group-ingress \
     --group-id $SG \
     --profile $PROFILE \
     --ip-permissions "IpProtocol=tcp,FromPort=${PORT},ToPort=${PORT},IpRanges=[{CidrIp=${CURRENT_IP}/32,Description=\"${RULE_NAME}\"}]"