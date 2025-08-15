#!/bin/bash

echo "🚀 Deploying Namazu Website with Docker..."

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

echo "✅ Docker and Docker Compose found!"

# Create logs directory if it doesn't exist
mkdir -p logs

# Build and start the container
echo "🔨 Building Docker image..."
docker-compose build

if [ $? -eq 0 ]; then
    echo "✅ Docker image built successfully!"
    
    echo "🚀 Starting Namazu website..."
    docker-compose up -d
    
    if [ $? -eq 0 ]; then
        echo ""
        echo "🎉 Namazu website is now running!"
        echo "🌐 Open your browser and go to: http://localhost:8080"
        echo ""
        echo "📋 Useful commands:"
        echo "   View logs: docker-compose logs -f"
        echo "   Stop: docker-compose down"
        echo "   Restart: docker-compose restart"
        echo "   Rebuild: docker-compose up --build -d"
    else
        echo "❌ Failed to start the container."
        exit 1
    fi
else
    echo "❌ Failed to build Docker image."
    exit 1
fi
