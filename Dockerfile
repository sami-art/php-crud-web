FROM public.ecr.aws/lts/ubuntu:latest

# Update packages and install necessary dependencies
RUN apt-get update \
    && apt-get install -y apache2 php7.4 php7.4-mysql libapache2-mod-php7.4\
    && apt-get install -y default-mysql-client \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Enable Apache mod_rewrite
RUN a2enmod rewrite

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
