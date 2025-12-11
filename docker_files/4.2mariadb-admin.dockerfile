# Use specific MariaDB version for stability
FROM mariadb:10.11

# Set root password (required)
ENV MYSQL_ROOT_PASSWORD=ChangeMe123!

# Create database and admin user with password
ENV MYSQL_DATABASE=app_database
ENV MYSQL_USER=dbadminuser
ENV MYSQL_PASSWORD=SecureAdminPass123!

# Copy custom initialization script
COPY ./scripts/ /docker-entrypoint-initdb.d/

# Set permissions for initialization scripts
RUN chmod -R 644 /docker-entrypoint-initdb.d/*

# Expose MariaDB port
EXPOSE 3306

# Optional: Set timezone
ENV TZ=UTC

# Health check
HEALTHCHECK --interval=30s --timeout=5s \
  CMD mysqladmin ping -u root -p${MYSQL_ROOT_PASSWORD} || exit 1
