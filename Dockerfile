# Use nginx alpine as base image for lightweight static file serving
FROM nginx:alpine

# Copy the website files to nginx's default serving directory
COPY index.html /usr/share/nginx/html/
COPY styles.css /usr/share/nginx/html/
COPY namazu.png /usr/share/nginx/html/

# Copy a custom nginx configuration for better performance
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
