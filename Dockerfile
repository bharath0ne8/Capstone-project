# Use the Node.js 14 Alpine image as the base
FROM node:14-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json files to the container in /app
COPY package.json ./
COPY package-lock.json ./

# Install application dependencies
RUN npm install --silent
RUN npm install react-scripts@3.4.1 -g --silent

# Copy the application files to the container
COPY . /app

# Expose port 80 to run the application
EXPOSE 80

# Define the command to start the application on port 80
CMD ["npm", "start", "--", "--port", "80"]
