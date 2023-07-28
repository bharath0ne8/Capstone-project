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
COPY . .

# Build the production version of the React application
RUN npm run build

# Use a lightweight HtP server to serve the production build
# Install serve globally
RUN npm install -g serve

# Set the command to run the HTTP server to serve the production build
CMD ["serve", "-s", "build", "-l", "80"]
