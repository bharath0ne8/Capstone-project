#!/bin/bash

# Build the Docker image
echo "Building Docker image..."
docker-compose build

# Run the Docker container using Docker Compose
echo "Starting the Docker container..."
docker-compose up -d

# Wait for a few seconds to allow the application to start
sleep 5

# Check the container logs for any errors
docker logs my-react-app-container

