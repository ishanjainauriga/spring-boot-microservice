#!/bin/bash

# Set variables
AWS_REGION="ap-south-1"
IMAGE_TAG="latest"
ECR_REPO_NAME="product-service"
CLUSTER_NAME="product-service-cluster"
#SERVICE_NAME="auth-server-ecs-service"
#TASK_DEFINITION_NAME="service-discovery-task-def"
#CONTAINER_NAME="service-discovery-app-container"
ACCOUNT_ID=597213519394
PORT_NO=8084

#Network Variables

# Build Docker image
docker build -t $ECR_REPO_NAME:$IMAGE_TAG .
# Docker Run
docker run -p $PORT_NO:$PORT_NO ECR_REPO_NAME:IMAGE_TAG

# Authenticate Docker to ECR
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

# Create ECR repository if it does not exist
aws ecr describe-repositories --repository-names $ECR_REPO_NAME --region $AWS_REGION || aws ecr create-repository --repository-name $ECR_REPO_NAME --region $AWS_REGION

# Tag and push Docker image to ECR
docker tag $ECR_REPO_NAME:$IMAGE_TAG $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO_NAME:$IMAGE_TAG
docker push $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO_NAME:$IMAGE_TAG


# Create ECS Cluster if it does not exist
#aws ecs describe-clusters --clusters $CLUSTER_NAME --region $AWS_REGION ||
aws ecs create-cluster --cluster-name $CLUSTER_NAME --region $AWS_REGION --settings name=containerInsights,value=enabled

## Create ECS Service
#aws ecs create-service \
#    --cluster $CLUSTER_NAME \
#    --service-name $SERVICE_NAME \
#    --task-definition $TASK_DEFINITION_NAME \
#    --desired-count 1 \
#    --launch-type "FARGATE" \
#    --network-configuration "awsvpcConfiguration={subnets=[subnet-12345678],securityGroups=[sg-12345678],assignPublicIp=ENABLED}" \
#    --region $AWS_REGION

echo "Deployment to ECS completed successfully."
