FROM public.ecr.aws/amazonlinux/amazonlinux:2

# Update packages and install necessary dependencies
RUN yum update -y \
    && yum install -y httpd php php-mysqlnd \
    && yum install -y mysql \
    && yum install -y apache2 \
    && rm -rf /var/cache/yum/*

# Enable Apache mod_rewrite
RUN sed -i 's/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf \
    && echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf \
    && echo "Listen 80" >> /etc/httpd/conf/httpd.conf \
    && chown apache:apache /var/www/html/ -R

# Set environment variables for MySQL connection
ENV MYSQL_HOST=""
ENV MYSQL_USER=""
ENV MYSQL_PASSWORD=""
ENV MYSQL_DATABASE=""

# Copy the application code to the container
COPY . /var/www/html/

# Add startup script
COPY startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh

# Expose port 80
EXPOSE 80

# Start the Apache web server and run startup script
CMD ["/usr/local/bin/startup.sh"]

