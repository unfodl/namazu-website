#!/bin/bash

echo "🚀 Deploying Namazu Website to Static Hosting..."

# Check if we're in the right directory
if [ ! -f "index.html" ]; then
    echo "❌ Error: index.html not found. Please run this script from the project root."
    exit 1
fi

# Create deployment directory
DEPLOY_DIR="deploy"
echo "📁 Creating deployment directory: $DEPLOY_DIR"
rm -rf "$DEPLOY_DIR"
mkdir -p "$DEPLOY_DIR"

# Copy all necessary files
echo "📋 Copying files..."
cp index.html "$DEPLOY_DIR/"
cp styles.css "$DEPLOY_DIR/"
cp namazu.png "$DEPLOY_DIR/"
cp why.html "$DEPLOY_DIR/"
cp .htaccess "$DEPLOY_DIR/"
cp Namazu.pdf "$DEPLOY_DIR/"

# Create a simple health check file
echo "✅ OK" > "$DEPLOY_DIR/health"

# Create a robots.txt file
cat > "$DEPLOY_DIR/robots.txt" << EOF
User-agent: *
Allow: /
Disallow: /health
EOF

# Create a sitemap
cat > "$DEPLOY_DIR/sitemap.xml" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
    <url>
        <loc>https://www.namazudao.com/</loc>
        <lastmod>$(date -u +%Y-%m-%d)</lastmod>
        <changefreq>weekly</changefreq>
        <priority>1.0</priority>
    </url>
    <url>
        <loc>https://www.namazudao.com/why.html</loc>
        <lastmod>$(date -u +%Y-%m-%d)</lastmod>
        <changefreq>monthly</changefreq>
        <priority>0.8</priority>
    </url>
</urlset>
EOF

# Verify all files are present
echo "🔍 Verifying deployment files..."
ls -la "$DEPLOY_DIR/"

echo ""
echo "✅ Deployment package ready in '$DEPLOY_DIR/' directory!"
echo ""
echo "📤 To deploy:"
echo "   1. Upload all files from '$DEPLOY_DIR/' to your hosting service"
echo "   2. Ensure your hosting service supports .htaccess files (Apache) or configure Nginx"
echo "   3. Test the website at your domain"
echo ""
echo "🌐 Test your deployment with:"
echo "   - Main page: https://yourdomain.com/"
echo "   - Why page: https://yourdomain.com/why.html"
echo "   - Health check: https://yourdomain.com/health"
echo "   - File test: https://yourdomain.com/test.html"
echo ""
echo "🔧 If you're still having issues:"
echo "   - Check your hosting service's static file serving configuration"
echo "   - Ensure all files have proper permissions (644 for files, 755 for directories)"
echo "   - Check the browser's developer console for specific error messages"
