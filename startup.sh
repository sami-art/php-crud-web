#!/bin/bash

# Wait for MySQL to start up
until mysql -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_PASSWORD -e ";" ; do
    >&2 echo "MySQL is unavailable - sleeping"
    sleep 1
done

# Create the table
mysql -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE < /var/www/html/peopledb.sql

# Start Apache web server
apache2-foreground
