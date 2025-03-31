# Use the official Nginx image as the base image
FROM nginx:alpine

# Copy the static website files to the Nginx HTML directory
COPY ./public /usr/share/nginx/html

# Expose port 80 for web traffic
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
