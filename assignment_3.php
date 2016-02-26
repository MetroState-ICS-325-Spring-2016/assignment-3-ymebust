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
// For this PHP script, we will use the `classicmodels` database.
// You must import this database into MySQL first using
// MySQL workbench.  See the README for this repo in GitHub.
$db_database = 'classicmodels';

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
//
// For your query, you will need to join the customers and employees
// tables together.
//The customer name, country, and sales rep name on one line per customer.
$query_result = $mysql_connection->query("SELECT customers.customerName, customers.country,
    employees.firstName, employees.lastName FROM customers, employees
    WHERE customers.salesrepemployeenumber = employees.employeenumber
    ORDER BY customers.country, customers.customerName");

// Make sure there wasn't an error with the query.
if ($query_result !== false) {
		// Fetch each row of the query result as an associative array.
		// http://php.net/manual/en/mysqli-result.fetch-assoc.php
		while ($row_array = $query_result->fetch_assoc()) {
			echo $row_array['customerName'] . ", " . $row_array['country'] . " - " . $row_array['firstName'] . " " .
				$row_array['lastName'] . "\n";// Your output goes here
		}


    // We're done with the query result set, so free it.
    // This frees up the memory the result set object was using.
    // http://php.net/manual/en/mysqli-result.free.php
    $query_result->free();
} else {
    // http://php.net/manual/en/mysqli.error.php
    echo "The query failed: $mysql_connection->error\n";
    exit(2);
}

// We're all done with the MySQL connection so close it.
// http://php.net/manual/en/mysqli.close.php
$mysql_connection->close();
