# Step 1: Build the React app
FROM node:18 as build

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json into the container
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application source code into the container
COPY . .

# Build the React app for production
RUN npm run build

# Step 2: Serve the app using Nginx
FROM nginx:alpine

# Copy the built React app from the previous step into Nginx's default html directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 to access the app
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
