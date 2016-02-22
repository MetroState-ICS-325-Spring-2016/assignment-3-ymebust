Assignment 3
============

Purpose
-------
To help you learn the basics of:
* MySQL (and MariaDB)
* MySQL Workbench
* Importing databases from SQL scripts
* Using PHP to query and report from a MySQL database

Prerequisites
-------------
* You will need MySQL installed.  If you are not part of the database course, install XAMPP.  If you are part of the MySQL course, you can use the MySQL version you installed already.
* You will need to install MySQL Workbench for free from [mysql.com](https://www.mysql.com/products/workbench/)
  - Note: If you use Windows, you may need to install Visual C++ Redistributable for Visual Studio 2013 and/or Microsoft .NET Framework 4 Client Profile.  Both are listed on the download page for MySQL Workbench.  If MySQL Workbench doesn't work, then try installing Visual C++ Redistributable for Visual Studio 2013 first.  If it still doesn't work, then try installing Microsoft .NET Framework 4 Client Profile.
* You will need to import people.sql and mysqlsampledatabase.sqlmysqlsampledatabase.sql into your MySQL database using MySQL workbench.
* You will need the mysqli extension for PHP.  The PHP version that comes with XAMPP has this built-in.

Assignment Set Up
-----------------
Make sure that MySQL is running.  If you have XAMPP, open the XAMPP control panel and click the "start" button next to MySQL.  If you are in the database course, MySQL may already be running in the background on your machine.

Open MySQL workbench.  If there is a button in the top left that says "Local instance 3306" click it and you will be logged into the MySQL server.

If not, click the + button next to "MySQL Connections".  Name the connection "Local instance 3306".  Hostname should be "127.0.0.1".  Port should be "3306".  Username should be "root".  The password is blank if you use XAMPP.  If you installed MySQL for the database course, you may need to enter a password.  Hit okay and then open the connection by clicking on it.

Once you are in MySQL Workbench, go to File->Run SQL Script...  Select the people.sql script.  Hit the "Run" button.  If it asks for a password, you do not need one if you use XAMPP. Once it is done, in the bottom left side of the screen is a panel that says "SCHEMAS".  Click the 2 headed arrow button next to it.  That will show you the schemas (databases) you have running.  Hit the refresh button (2 arrows in a circle) to see the examples database that was created by people.sql.  Click on the + next to examples to see the people table.  To run queries against a database, double click it.  The database name will turn bold.  Any queries you execute in you query window will run against the bolded database by default.

Now go to File->Run SQL Script... again, but this time select mysqlsampledatabase.sql.  Import it the same way.  Once you are done and refresh the schemas, you will see the classicmodels database.  Double click that database to select it.

Resources and Examples
----------------------
Chapter 8 in the book goes over the basics of a database.  Chapter 10 goes over common database operations such as SELECT, INSERT, UPDATE, ALTER, and various types of joins.  You should read these chapters of the book.

The sample database we will be using comes from the site [mysqltutorial.org](http://www.mysqltutorial.org/).  You will probably find it helpful to go through their examples on the following topics which make use of that sample database:
* [basics of the SELECT statement](http://www.mysqltutorial.org/mysql-select-statement-query-data.aspx) (read from the database)
* [basics of the WHERE clause](http://www.mysqltutorial.org/mysql-where/) (used with SELECT, INSERT, UPDATE)
* [basics of the ORDER BY clause](http://www.mysqltutorial.org/mysql-order-by/) (sorting SELECT results)
* [basics of the IN operator](http://www.mysqltutorial.org/sql-in.aspx) (part of WHERE clause)
* [basics of the AS keyword](http://www.mysqltutorial.org/mysql-alias/) (aliases for tables, select values, etc)
* [basics of the GROUP BY clause](http://www.mysqltutorial.org/mysql-group-by.aspx) (used with SELECT for calculating aggregates)
* [basics of the INNER JOIN clause](http://www.mysqltutorial.org/mysql-inner-join.aspx) (the default JOIN for MySQL):
* [basics of a sub-query](http://www.mysqltutorial.org/mysql-subquery/)
* [basics of aggregate functions](http://www.mysqltutorial.org/mysql-aggregate-functions.aspx)

Files in this Repo
------------------
* **people.sql** - Schema and data used by the assignment_1_example.php example.
* **mysqlsampledatabase.sql** - Schema and data used by example_sql_statements.sql and the assignment 3 problems.
* **example_sql_statements.sql** - Example SQL statements using the example database from mysqlsampledatabase.sql.
* **assignment_1_example.php** - Shows how to accomplish some of assignment 1 using a database.  Look at this to see how to interace with MySQL from PHP.
* **assignment_3_problems.txt** - Contains instructions on how to complete the assignment and how it is graded.
* **assignment_3.php** - A script you need to modify to perform a SQL query and print the results to the terminal.  Referred to by assignment_3_problems.txt.
* **assignment_3_solution_output.txt** - Your completed assignment_3.php output should look like this

How to Turn in the Assignment
-----------------------------
You need to clone your private git repo for assignment 3.  Make changes assignment_3.php to complete problem 6.  For problems 1 though 5, edit the file assignment_3_problems.txt and follow the instructions given within that file for recording your answers.

Once you are done, commit your modifications to your master branch and push them to GitHub.  Then go to D2L and turn in the assignment to let me know I can go look at your repo and grade you.  D2L requires you to upload a file, so just upload a blank file or one that says "I'm done."
