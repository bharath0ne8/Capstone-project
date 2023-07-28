#!/bin/bash

# Public IP address of your EC2 instance
EC2_PUBLIC_IP="13.233.164.216"

# SSH key to access the EC2 instance. Replace "YOUR_SSH_KEY.pem" with your actual SSH key file.
SSH_KEY="capstone.pem"

# SSH user for the EC2 instance. Replace "ec2-user" with your EC2 instance's username.
SSH_USER="ubuntu"

# Name of the Docker Compose YAML file (assuming it's in the same directory as the script).
DOCKER_DOCKERFILE="Dockerfile"


# Name of the Docker Compose YAML file (assuming it's in the same directory as the script).
DOCKER_COMPOSE_FILE="docker-compose.yml"

# Copy the Docker Compose YAML file and the shell script to the EC2 instance.
scp -i "$SSH_KEY" "$DOCKER_DOCKERFILE" "$SSH_USER"@"$EC2_PUBLIC_IP":/home/"$SSH_USER"/
scp -i "$SSH_KEY" "$DOCKER_COMPOSE_FILE" "$SSH_USER"@"$EC2_PUBLIC_IP":/home/"$SSH_USER"/
scp -i "$SSH_KEY" build.sh "$SSH_USER"@"$EC2_PUBLIC_IP":/home/"$SSH_USER"/

# SSH into the EC2 instance and deploy the Docker containers.
ssh -i "$SSH_KEY" "$SSH_USER"@"$EC2_PUBLIC_IP" << EOF
  # Go to the directory where the Docker Compose file is located
  cd /home/"$SSH_USER"

  # Make the shell script executable
  chmod +x build.sh

  # Build and run the Docker containers using Docker Compose
  ./build.sh

  # Optional: Stop and remove any previously running containers to clean up
  docker-compose down

  # Start the Docker containers in the background
  docker-compose up -d
EOF
