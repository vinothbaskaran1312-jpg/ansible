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
RUN echo 'Webserver app deployed using Docker Build- shajahan' > ${DOCUMENT_ROOT}/index.html

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
