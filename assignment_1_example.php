<?php

// This is the hostname or IP of the database server.
// Since we are using MySQL running on the same computer as your
// PHP code, you would use either 127.0.0.1 or localhost.  Both
// are reserved in the IP protocol to refer to this system (the local computer).
$db_hostname = '127.0.0.1';

// A username is required to connec to MySQL.  Be default, the root
// user is the only user.  If you install XAMPP with default options,
// you can use the root user.
$db_username = 'root';

// A password may be required for the user.  By default, XAMPP does
// not set a password for the root user.  If you are in the database
// class and installed MySQL separatly from XAMPP, you may have a
// password set.  If that is the case, set it here.
$db_password = '';

// Typically you want to specify what database to use.
// For this PHP script, we will use the `examples` database.
$db_database = 'examples';

// Use the mysqli extension to connect to the MySQL server using the object-oriented mysqli interface.
// Note: the '@' is the error control operator.  It suppresses any errors from being printed out.
//       Since we will be checking if the connection is ok, we don't need any errors to be printed,
//       as we will be printing errors explicitly.
// http://php.net/manual/en/mysqli.quickstart.connections.php
// http://php.net/manual/en/language.operators.errorcontrol.php
$mysql_connection = @new mysqli($db_hostname, $db_username, $db_password, $db_database);

// Make sure that the connection to the MySQL database is ok.
if ($mysql_connection->connect_errno) {
    // http://php.net/manual/en/mysqli.connect-error.php
    printf("Failed to connect to the MySQL database server: %s\n", $mysql_connection->connect_error);

    // Specify a non-zero exit code.  By default, exit() will return 0 to the shell.
    // 0 means the program worked correctly without an error.  Since there is an error, we want
    // the shell to know that.  We will use a different number for each error in the program.
    // http://php.net/manual/en/function.exit.php
    exit(1);
}

// Perform a SELECT query using the object-oriented mysqli interface.
// http://php.net/manual/en/mysqli.query.php
$query_result = $mysql_connection->query("SELECT * from `people`");

// Make sure there wasn't an error with the query.
if ($query_result !== false) {
    // Fetch each row of the query result as an associative array.
    // http://php.net/manual/en/mysqli-result.fetch-assoc.php
    //
    // Notice that the result set is printed in alphabetical order of last name, first name
    // without an ORDER BY clause.  This is the case because we defined the primary key of
    // the table to be (lname, fname).
    while($row_array = $query_result->fetch_assoc()) {
        echo $row_array['fname'] . " " . $row_array['lname'] . " likes " . $row_array['color'] . ", " .
        $row_array['food'] . ", " . $row_array['game'] .", and " . $row_array['lang'] . ".\n";
    }

    // Record the number of rows in the `people` table.
    //
    // Since we fetched all the rows in the `people` table,
    // the number of rows in the result set is the number of rows
    // in the `people` table.
    // http://php.net/manual/en/mysqli-result.num-rows.php
    $number_people = $query_result->num_rows;

    // We're done with the query result set, so free it.
    // This frees up the memory the result set object was using.
    // http://php.net/manual/en/mysqli-result.free.php
    $query_result->free();
} else {
    // http://php.net/manual/en/mysqli.error.php
    echo "The query failed: $mysql_connection->error\n";
    exit(2);
}

echo "\nThere are $number_people rows in the `people` table.\n\n";

// select all the color column values, group them by color value, and count how many
// of each value is present.  Finally, order the results in descending order based on the
// count of each color.
$query_result = $mysql_connection->query("SELECT `color`, COUNT(`color`) AS `colorTotal`
                                          FROM `people` GROUP BY `color` ORDER BY COUNT(`color`) DESC");
if ($query_result !== false) {
    echo "Color\n";
    while($row_array = $query_result->fetch_assoc()) {
        printf("    %.2f%% %s\n", ($row_array['colorTotal'] / $number_people) * 100, $row_array['color']);
    }
    $query_result->free();
} else {
    echo "The query failed: $mysql_connection->error\n";
    exit(3);
}

$query_result = $mysql_connection->query("SELECT `food`, COUNT(`food`) AS `foodTotal`
                                          FROM `people` GROUP BY `food` ORDER BY COUNT(`food`) DESC");
if ($query_result !== false) {
    echo "Food\n";
    while($row_array = $query_result->fetch_assoc()) {
        printf("    %.2f%% %s\n", ($row_array['foodTotal'] / $number_people) * 100, $row_array['food']);
    }
    $query_result->free();
} else {
    echo "The query failed: $mysql_connection->error\n";
    exit(3);
}

$query_result = $mysql_connection->query("SELECT `game`, COUNT(`game`) AS `gameTotal`
                                          FROM `people` GROUP BY `game` ORDER BY COUNT(`game`) DESC");
if ($query_result !== false) {
    echo "Game\n";
    while($row_array = $query_result->fetch_assoc()) {
        printf("    %.2f%% %s\n", ($row_array['gameTotal'] / $number_people) * 100, $row_array['game']);
    }
    $query_result->free();
} else {
    echo "The query failed: $mysql_connection->error\n";
    exit(3);
}

$query_result = $mysql_connection->query("SELECT `lang`, COUNT(`lang`) AS `langTotal`
                                          FROM `people` GROUP BY `lang` ORDER BY COUNT(`lang`) DESC");
if ($query_result !== false) {
    echo "Lang\n";
    while($row_array = $query_result->fetch_assoc()) {
        printf("    %.2f%% %s\n", ($row_array['langTotal'] / $number_people) * 100, $row_array['lang']);
    }
    $query_result->free();
} else {
    echo "The query failed: $mysql_connection->error\n";
    exit(3);
}

// We're all done with the MySQL connection so close it.
// http://php.net/manual/en/mysqli.close.php
$mysql_connection->close();