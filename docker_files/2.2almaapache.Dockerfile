# Use AlmaLinux 9 as base image
FROM almalinux:9

# Set environment variables
ENV DOCUMENT_ROOT=/var/www/html \
    HTTPD_CONF_DIR=/etc/httpd/conf \
    HTTPD_CONF_D_DIR=/etc/httpd/conf.d

# Install Apache HTTPd and clean cache
RUN dnf update -y && \
    dnf install -y httpd && \
    dnf clean all && \
    rm -rf /var/cache/dnf

# Create a sample homepage
RUN echo '<!DOCTYPE html>' > ${DOCUMENT_ROOT}/index.html && \
    echo '<html lang="en">' >> ${DOCUMENT_ROOT}/index.html && \
    echo '<head>' >> ${DOCUMENT_ROOT}/index.html && \
    echo '    <meta charset="UTF-8">' >> ${DOCUMENT_ROOT}/index.html && \
    echo '    <meta name="viewport" content="width=device-width, initial-scale=1.0">' >> ${DOCUMENT_ROOT}/index.html && \
    echo '    <title>AlmaLinux Apache Server</title>' >> ${DOCUMENT_ROOT}/index.html && \
    echo '    <style>' >> ${DOCUMENT_ROOT}/index.html && \
    echo '        body { font-family: Arial, sans-serif; margin: 0; padding: 20px; background-color: #f0f0f0; }' >> ${DOCUMENT_ROOT}/index.html && \
    echo '        .container { max-width: 800px; margin: 0 auto; background-color: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }' >> ${DOCUMENT_ROOT}/index.html && \
    echo '        h1 { color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom: 10px; }' >> ${DOCUMENT_ROOT}/index.html && \
    echo '        .logo { color: #3498db; font-weight: bold; }' >> ${DOCUMENT_ROOT}/index.html && \
    echo '        .info { background-color: #f8f9fa; padding: 15px; border-left: 4px solid #3498db; margin: 20px 0; }' >> ${DOCUMENT_ROOT}/index.html && \
    echo '        .footer { margin-top: 30px; color: #7f8c8d; font-size: 0.9em; text-align: center; }' >> ${DOCUMENT_ROOT}/index.html && \
    echo '    </style>' >> ${DOCUMENT_ROOT}/index.html && \
    echo '</head>' >> ${DOCUMENT_ROOT}/index.html && \
    echo '<body>' >> ${DOCUMENT_ROOT}/index.html && \
    echo '    <div class="container">' >> ${DOCUMENT_ROOT}/index.html && \
    echo '        <h1>Welcome to <span class="logo">Apache HTTP Server</span> on AlmaLinux</h1>' >> ${DOCUMENT_ROOT}/index.html && \
    echo '        <div class="info">' >> ${DOCUMENT_ROOT}/index.html && \
    echo '            <p>This is a sample homepage served by Apache HTTPd running in a Docker container.</p>' >> ${DOCUMENT_ROOT}/index.html && \
    echo '            <p><strong>Container ID:</strong> '$(hostname)'</p>' >> ${DOCUMENT_ROOT}/index.html && \
    echo '            <p><strong>Server Time:</strong> <span id="datetime"></span></p>' >> ${DOCUMENT_ROOT}/index.html && \
    echo '        </div>' >> ${DOCUMENT_ROOT}/index.html && \
    echo '        <h2>Server Information:</h2>' >> ${DOCUMENT_ROOT}/index.html && \
    echo '        <ul>' >> ${DOCUMENT_ROOT}/index.html && \
    echo '            <li><strong>Base OS:</strong> AlmaLinux 9</li>' >> ${DOCUMENT_ROOT}/index.html && \
    echo '            <li><strong>Web Server:</strong> Apache HTTPd</li>' >> ${DOCUMENT_ROOT}/index.html && \
    echo '            <li><strong>Document Root:</strong> /var/www/html</li>' >> ${DOCUMENT_ROOT}/index.html && \
    echo '            <li><strong>Port:</strong> 80</li>' >> ${DOCUMENT_ROOT}/index.html && \
    echo '        </ul>' >> ${DOCUMENT_ROOT}/index.html && \
    echo '        <div class="footer">' >> ${DOCUMENT_ROOT}/index.html && \
    echo '            <p>Container started successfully! The Apache service is running in the foreground.</p>' >> ${DOCUMENT_ROOT}/index.html && \
    echo '        </div>' >> ${DOCUMENT_ROOT}/index.html && \
    echo '    </div>' >> ${DOCUMENT_ROOT}/index.html && \
    echo '    <script>' >> ${DOCUMENT_ROOT}/index.html && \
    echo '        function updateDateTime() {' >> ${DOCUMENT_ROOT}/index.html && \
    echo '            const now = new Date();' >> ${DOCUMENT_ROOT}/index.html && \
    echo '            document.getElementById("datetime").textContent = now.toLocaleString();' >> ${DOCUMENT_ROOT}/index.html && \
    echo '        }' >> ${DOCUMENT_ROOT}/index.html && \
    echo '        updateDateTime();' >> ${DOCUMENT_ROOT}/index.html && \
    echo '        setInterval(updateDateTime, 1000);' >> ${DOCUMENT_ROOT}/index.html && \
    echo '    </script>' >> ${DOCUMENT_ROOT}/index.html && \
    echo '</body>' >> ${DOCUMENT_ROOT}/index.html && \
    echo '</html>' >> ${DOCUMENT_ROOT}/index.html

# Set proper permissions
RUN chown -R apache:apache ${DOCUMENT_ROOT} && \
    chmod -R 755 ${DOCUMENT_ROOT}

# Expose port 80
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

# Start Apache in foreground mode
CMD ["httpd", "-D", "FOREGROUND"]
