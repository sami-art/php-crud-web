FROM php:7.4-apache

# Install necessary packages and dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libpq-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-install pdo_mysql mysqli pdo_pgsql pgsql gd

# Set environment variables for MySQL connection
ENV MYSQL_HOST=""
ENV MYSQL_USER=""
ENV MYSQL_PASSWORD=""
ENV MYSQL_DATABASE=""

# Copy the application code to the container
COPY . /var/www/html/

# Install MySQL client
RUN apt-get update && apt-get install -y default-mysql-client

# Add startup script
COPY startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh

# Expose port 80
EXPOSE 80

# Start the Apache web server and run startup script
CMD ["/usr/local/bin/startup.sh"]
