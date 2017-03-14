#!/bin/bash

# Get Global IP
gip=`curl -q http://169.254.169.254/latest/meta-data/public-ipv4`

# Get Instance-id
instanceid=`curl -q http://169.254.169.254/latest/meta-data/instance-id/`

# AWS Route53 Hosted ID
r53_hosted_id=${HOSTED_ZONE_ID} 

# update domain a record
r53_target_domain=${DOMAIN} 

# JSON output
outfile="/tmp/update.json"

# slackapi url
slackapi=${SLACKAPI}

# aws-cli route53 JSON(update.json) create
json="{\"Comment\" : \"\", \"Changes\" : [{\"Action\" : \"UPSERT\", \"ResourceRecordSet\" : {\"Name\" : \"${r53_target_domain}\", \"Type\" : \"A\", \"TTL\" : 300, \"ResourceRecords\" : [{\"Value\": \"${gip}\"}]}}]}"
echo $json > $outfile
# aws-cli
aws route53 change-resource-record-sets --hosted-zone-id $r53_hosted_id --change-batch file://$outfile

# Slack Post
if [ "${slackapi}" != "" ]; then
    curl -X POST --data-urlencode "payload={
        \"channel\": \"#channel\",
        \"username\": \"ip watch\",
        \"text\": \"updating global IP ${gip} / Instance ID ${instanceid}\",
        \"icon_emoji\": \":tiger:\"
    }" ${slackapi}
fi
