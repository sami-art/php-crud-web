<?php
 $db = mysqli_connect($_ENV['MYSQL_HOST'], $_ENV['MYSQL_USER'], $_ENV['MYSQL_PASSWORD'], $_ENV['MYSQL_DATABASE']) or
        die ('Unable to connect. Check your connection parameters.');
        mysqli_select_db($db, $_ENV['MYSQL_DATABASE']) or die(mysqli_error($db));
?>
