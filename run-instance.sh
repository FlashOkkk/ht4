#!/bin/bash

# Змінні
AMI_ID="ami-053b0d53c279acc90"
INSTANCE_TYPE="t2.micro"
KEY_NAME="aws-devops-2024"
SECURITY_GROUP_ID="sg-0b1dbb5274b0e3edc"
SUBNET_ID="subnet-00502f7647778e0df"
USER_DATA_FILE="setup-instance.sh"

# Перевірка наявності setup-instance.sh
if [ ! -f "$USER_DATA_FILE" ]; then
  echo "Error: User data file $USER_DATA_FILE not found!"
  exit 1
fi

# Запуск EC2 інстанції
aws ec2 run-instances \
    --image-id $AMI_ID \
    --count 1 \
    --instance-type $INSTANCE_TYPE \
    --key-name $KEY_NAME \
    --security-group-ids $SECURITY_GROUP_ID \
    --subnet-id $SUBNET_ID \
    --user-data file://$USER_DATA_FILE

if [ $? -eq 0 ]; then
  echo "EC2 instance launched successfully!"
else
  echo "Failed to launch EC2 instance."
  exit 1
fi
