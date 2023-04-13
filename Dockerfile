FROM samiulislam807/amazonlinux-php-apache:latest

# Install necessary packages and dependencies
RUN yum update && \
    yum install -y \
    httpd \
    php \
    php-devel \
    git \
    unzip \
    postgresql-devel \
    libpng-devel \
    libjpeg-devel \
    freetype-devel

# Enable necessary Apache modules
RUN echo "LoadModule rewrite_module modules/mod_rewrite.so" >> /etc/httpd/conf/httpd.conf && \
    echo "LoadModule headers_module modules/mod_headers.so" >> /etc/httpd/conf/httpd.conf

# Install necessary PHP extensions
RUN docker-php-ext-install pdo_mysql mysqli pdo_pgsql pgsql gd

# Set environment variables for MySQL connection
ENV MYSQL_HOST=""
ENV MYSQL_USER=""
ENV MYSQL_PASSWORD=""
ENV MYSQL_DATABASE=""

# Copy the application code to the container
COPY . /var/www/html/

# Install MySQL client
RUN yum update && yum install -y default-mysql-client

# Add startup script
COPY startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh

# Expose port 80
EXPOSE 80

# Start the Apache web server and run startup script
CMD ["/usr/local/bin/startup.sh"]
