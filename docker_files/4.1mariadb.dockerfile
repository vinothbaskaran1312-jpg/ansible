# Use official MariaDB image
FROM mariadb:latest

# Set environment variables
ENV MYSQL_ROOT_PASSWORD=root_password
ENV MYSQL_DATABASE=defaultdb
ENV MYSQL_USER=dbadminuser
ENV MYSQL_PASSWORD=admin_password

# Expose MariaDB port
EXPOSE 3306

# Health check to ensure MariaDB is running
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
  CMD mysqladmin ping -h localhost -u root -p${MYSQL_ROOT_PASSWORD} || exit 1

# Optional: Copy custom configuration file if needed
# COPY my.cnf /etc/mysql/conf.d/

# Optional: Copy initialization scripts for additional setup
# COPY init.sql /docker-entrypoint-initdb.d/

# Add custom initialization script to grant dbadminuser additional privileges
COPY --chmod=644 ./scripts/init-admin.sql /docker-entrypoint-initdb.d/01-init-admin.sql
