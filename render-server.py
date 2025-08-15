#!/usr/bin/env python3
"""
Production server for Namazu website - Render compatible
Binds to 0.0.0.0 to accept external connections
"""

import http.server
import socketserver
import os
from pathlib import Path

# Configuration
PORT = int(os.environ.get('PORT', 8000))
HOST = '0.0.0.0'

class CustomHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    """Custom HTTP request handler with better error handling"""
    
    def end_headers(self):
        # Add CORS headers for web compatibility
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        super().end_headers()
    
    def log_message(self, format, *args):
        # Custom logging format
        print(f"[{self.log_date_time_string()}] {format % args}")

def main():
    """Start the HTTP server"""
    # Change to the directory containing this script
    script_dir = Path(__file__).parent
    os.chdir(script_dir)
    
    # Create server
    with socketserver.TCPServer((HOST, PORT), CustomHTTPRequestHandler) as httpd:
        print(f"🚀 Namazu Website Server Starting...")
        print(f"🌐 Host: {HOST}")
        print(f"🔌 Port: {PORT}")
        print(f"📁 Directory: {os.getcwd()}")
        print(f"🌍 Server will be available at: http://{HOST}:{PORT}")
        print(f"📱 Press Ctrl+C to stop the server")
        print("-" * 50)
        
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\n🛑 Server stopped by user")
        except Exception as e:
            print(f"❌ Server error: {e}")

if __name__ == "__main__":
    main()
