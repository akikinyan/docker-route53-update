#!/bin/bash

# create aws-cli configure
mkdir /root/.aws

#OUTPUT=${1}
#REGION=${2}
output="[default]\noutput = ${OUTPUT}\nregion = ${REGION}\n"
# echo -e ${output}
echo -e ${output} > /root/.aws/config

#AWS_ACCESS_KEY_ID=${3}
#AWS_SECRET_ACCESS_KEY=${4}
output="[default]\naws_access_key_id = ${AWS_ACCESS_KEY_ID}\naws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}\n"
# echo -e ${output}
echo -e ${output} > /root/.aws/credentials

# Route53 update 
/root/ip_watch.sh

exit 0
