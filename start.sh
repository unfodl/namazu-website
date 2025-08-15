#!/bin/bash

echo "🚀 Starting Namazu Website..."

# Check if Python 3 is available
if command -v python3 &> /dev/null; then
    echo "✅ Python 3 found, starting server..."
    echo "🌐 Website will be available at: http://0.0.0.0:8000"
    echo "📱 Press Ctrl+C to stop the server"
    echo ""
    python3 -m http.server 8000 --bind 0.0.0.0
elif command -v python &> /dev/null; then
    echo "✅ Python found, starting server..."
    echo "🌐 Website will be available at: http://0.0.0.0:8000"
    echo "📱 Press Ctrl+C to stop the server"
    echo ""
    python -m http.server 8000 --bind 0.0.0.0
else
    echo "❌ Python not found!"
    echo "Please install Python 3 or open index.html directly in your browser."
    exit 1
fi
