#!/bin/bash

#Retag image. Seems to not work properly on windows gitbash for some reason.
MANIFEST=$(aws ecr batch-get-image --region $ECR_REGION --repository-name $ECR_REPOSITORY_NAME --image-ids imageTag=$EXISTING_ECR_TAG --query 'images[].imageManifest' --output text)
aws ecr put-image --region $ECR_REGION --repository-name $ECR_REPOSITORY_NAME --image-tag $NEW_ECR_TAG --image-manifest "$MANIFEST"

aws ecr describe-images --repository-name dd-api --image-ids imageTag=latest