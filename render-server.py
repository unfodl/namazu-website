#!/usr/bin/env python3
"""
Production server for Namazu website - Render compatible
Binds to 0.0.0.0 to accept external connections
"""

import http.server
import socketserver
import os
from pathlib import Path
import time

# Configuration
PORT = int(os.environ.get('PORT', 8000))
HOST = '0.0.0.0'

class CustomHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    """Custom HTTP request handler with better error handling and caching"""
    
    def end_headers(self):
        # Add CORS headers for web compatibility
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        
        # Add cache control headers
        if self.path.endswith('.css') or self.path.endswith('.js'):
            # CSS and JS files - cache for 1 hour
            self.send_header('Cache-Control', 'public, max-age=3600')
        elif self.path.endswith('.png') or self.path.endswith('.jpg') or self.path.endswith('.jpeg') or self.path.endswith('.gif'):
            # Images - cache for 1 day
            self.send_header('Cache-Control', 'public, max-age=86400')
        elif self.path.endswith('.html'):
            # HTML files - no cache for development
            self.send_header('Cache-Control', 'no-cache, no-store, must-revalidate')
            self.send_header('Pragma', 'no-cache')
            self.send_header('Expires', '0')
        else:
            # Other files - cache for 1 hour
            self.send_header('Cache-Control', 'public, max-age=3600')
        
        super().end_headers()
    
    def log_message(self, format, *args):
        # Custom logging format with timestamp
        timestamp = time.strftime('%Y-%m-%d %H:%M:%S')
        print(f"[{timestamp}] {format % args}")
    
    def do_GET(self):
        # Add timestamp to prevent aggressive caching during development
        if self.path.endswith('.html'):
            self.path += f'?t={int(time.time())}' if '?' not in self.path else f'&t={int(time.time())}'
        
        super().do_GET()

def main():
    """Start the HTTP server"""
    # Change to the directory containing this script
    script_dir = Path(__file__).parent
    os.chdir(script_dir)
    
    # Create server with better error handling
    try:
        with socketserver.TCPServer((HOST, PORT), CustomHTTPRequestHandler) as httpd:
            # Allow reuse of address
            httpd.allow_reuse_address = True
            
            print(f"🚀 Namazu Website Server Starting...")
            print(f"🌐 Host: {HOST}")
            print(f"🔌 Port: {PORT}")
            print(f"📁 Directory: {os.getcwd()}")
            print(f"🌍 Server will be available at: http://{HOST}:{PORT}")
            print(f"📱 Press Ctrl+C to stop the server")
            print(f"🔒 Cache headers configured for optimal hosting")
            print("-" * 50)
            
            try:
                httpd.serve_forever()
            except KeyboardInterrupt:
                print("\n🛑 Server stopped by user")
            except Exception as e:
                print(f"❌ Server error: {e}")
    except OSError as e:
        if "Address already in use" in str(e):
            print(f"❌ Port {PORT} is already in use. Try a different port or stop the existing server.")
        else:
            print(f"❌ Server error: {e}")
    except Exception as e:
        print(f"❌ Unexpected error: {e}")

if __name__ == "__main__":
    main()
