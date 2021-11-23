#!/bin/bash

#Retag image. Seems to not work properly on windows gitbash for some reason.
MANIFEST=$(aws ecr batch-get-image --region $ECR_REGION --repository-name $ECR_REPOSITORY_NAME --image-ids imageTag=$EXISTING_ECR_TAG --query 'images[].imageManifest' --output text)
aws ecr put-image --region $ECR_REGION --repository-name $ECR_REPOSITORY_NAME --image-tag $NEW_ECR_TAG --image-manifest "$MANIFEST"

aws ecr describe-images --repository-name dd-api --image-ids imageTag=latest

aws elbv2 describe-target-groups --query "TargetGroups[?VpcId == 'vpc-018ab8d575f3fa8f9']"

aws ssm describe-instance-information --output json --query "InstanceInformationList[?contains(ComputerName, 'somestuff')]"

aws eks update-nodegroup-config --cluster-name clusterName --nodegroup-name nodeGroupName --scaling-config "minSize=2,maxSize=2,desiredSize=2"

aws s3 cp "$FILENAME" s3://bucket/folder/"$FILENAME"

# Get the most recent file that contains a substring
FILE=$(aws s3api list-objects-v2 --bucket "$BUCKET" --query "reverse(sort_by(Contents[?contains(Key, \`$SUBSTRING\`)], &LastModified))[].Key" --output=text)
aws s3 cp "s3://$BUCKET/$FILE" .