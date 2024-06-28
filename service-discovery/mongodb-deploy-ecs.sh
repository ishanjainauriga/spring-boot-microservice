#!/bin/bash

# Set variables
AWS_REGION="ap-south-1"
ECR_REPO_NAME="mongodb/mongodb-community-server"
IMAGE_TAG="latest"
CLUSTER_NAME="mongodb-ecs-cluster"
SERVICE_NAME="mongodb-ecs-service"
TASK_DEFINITION_NAME="mongodb-task-def"
CONTAINER_NAME="mongodb-app-container"
ACCOUNT_ID=597213519394


# Authenticate Docker to ECR
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

# Create ECR repository if it does not exist
aws ecr describe-repositories --repository-names $ECR_REPO_NAME --region $AWS_REGION || aws ecr create-repository --repository-name $ECR_REPO_NAME --region $AWS_REGION

# Tag and push Docker image to ECR
docker tag $ECR_REPO_NAME:$IMAGE_TAG $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO_NAME:$IMAGE_TAG
docker push $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO_NAME:$IMAGE_TAG