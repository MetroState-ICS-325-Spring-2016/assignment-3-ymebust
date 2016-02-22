/* First we pick a customer from the customers table.
We'll use customer 'Tekni Collectables Inc.' customerNumber 328. */

/* Let's see all their orders using the customerNumber. */
SELECT * FROM `orders` where `orders`.`customerNumber`=328;

/* They have 3 orders.  Let's get the details for each order.
The orderdetails table references the orderNumber from
the orders table.  Let's join the tables using those columns. */
SELECT `orderdetails`.* FROM `orderdetails`
INNER JOIN `orders`
ON `orderdetails`.`orderNumber`=`orders`.`orderNumber`
WHERE `orders`.`customerNumber`=328;

/* It's hard to tell what they ordered, since we only have
the productCode.  Let's join our query against the products
table to get more information on each product. The orderdetails
table references the products table using the produceCode field.
So we'll join the tables using that field. */
SELECT `orderdetails`.*, `products`.`productName` FROM `orderdetails`
INNER JOIN (`orders`, `products`)
ON `orderdetails`.`orderNumber`=`orders`.`orderNumber` AND
   `products`.`productCode`=`orderdetails`.`productCode`
WHERE `orders`.`customerNumber`=328;

/* It looks like the order line numbers aren't in order in our results.
It would be nice if they were listed in order. So, we'll use ORDER BY
to do that.  First we'll order by the orderNumber to keep all the line
items together.  Next, we'll order by the orderLineNumber. */
SELECT `orderdetails`.*, `products`.`productName` FROM `orderdetails`
INNER JOIN (`orders`, `products`)
ON `orderdetails`.`orderNumber`=`orders`.`orderNumber` AND
   `products`.`productCode`=`orderdetails`.`productCode`
WHERE `orders`.`customerNumber`=328
ORDER BY `orderdetails`.`orderNumber`, `orderdetails`.`orderLineNumber`;

/* Let's calculate the total price for each line item.  Notice that
a quantity and price are given in orderDetails.  We'll use those to
calculate a line item total. We'll refer to that total using the AS
keyword. */
SELECT `orderdetails`.*, `products`.`productName`,
       `orderdetails`.`priceEach` * `quantityOrdered` AS `productTotal`
FROM `orderdetails`
INNER JOIN (`orders`, `products`)
ON `orderdetails`.`orderNumber`=`orders`.`orderNumber` AND
   `products`.`productCode`=`orderdetails`.`productCode`
WHERE `orders`.`customerNumber`=328
ORDER BY `orderdetails`.`orderNumber`, `orderdetails`.`orderLineNumber`;

/* Notice that because priceEach is stored using DOUBLE the totals
show up with weird values such as: 5533.610000000001
This is a good example that shows what happens when a DOUBLE or FLOAT
is used instead of a DECIMAL to store values that should be stored
as DECIMAL.  Let's fix that by altering the table and chaning the
column type to DECIMAL(15,2) from DOUBLE.  The 15 means that
a decimal with 15 digits can be stored.  The 2 means that 2 of those
digits are past the decimal point.  For example: 1002.15. */
ALTER TABLE `classicmodels`.`orderdetails`
CHANGE COLUMN `priceEach` `priceEach` DECIMAL(15,2) NOT NULL ;

/* Now try the same query again to get total prices for each line item.
Notice that this time the calculated values are what we would expect. */
SELECT `orderdetails`.*, `products`.`productName`,
       `orderdetails`.`priceEach` * `quantityOrdered` AS `productTotal`
FROM `orderdetails`
INNER JOIN (`orders`, `products`)
ON `orderdetails`.`orderNumber`=`orders`.`orderNumber` AND
   `products`.`productCode`=`orderdetails`.`productCode`
WHERE `orders`.`customerNumber`=328
ORDER BY `orderdetails`.`orderNumber`, `orderdetails`.`orderLineNumber`;

/* Let's calculate the total for each order.  To do so, we'll use the
GROUP BY clause to group the rows based on the order number.  Then
we'll use the aggregate SUM() function to calculate a SUM() of the
grouped rows. We'll use AS to refer to the calculated sum as orderTotal. */
SELECT `orderdetails`.`orderNumber`,
       SUM(`orderdetails`.`priceEach` * `quantityOrdered`) AS `orderTotal`
FROM `orderdetails`
INNER JOIN (`orders`, `products`)
ON `orderdetails`.`orderNumber`=`orders`.`orderNumber` AND
   `products`.`productCode`=`orderdetails`.`productCode`
WHERE `orders`.`customerNumber`=328
GROUP BY `orderdetails`.`orderNumber`;

/* It's a little hard to read those big numbers, so let's format
them to be easier to read using the FORMAT() function. The 1st parameter
is the number to be formated.  The 2nd parameter is the number of decimal places
to show.  The last parameter is a locale that tells MySQL what type of separators
should be used.  For example, where to use a comma or a period for the decimal point.
The locale we used is English - United States.
For a list of locales, see:
http://dev.mysql.com/doc/refman/5.7/en/locale-support.html */
SELECT `orderdetails`.`orderNumber`,
       FORMAT(SUM(`orderdetails`.`priceEach` * `quantityOrdered`),2,'en_US') AS `orderTotal`
FROM `orderdetails`
INNER JOIN (`orders`, `products`)
ON `orderdetails`.`orderNumber`=`orders`.`orderNumber` AND
   `products`.`productCode`=`orderdetails`.`productCode`
WHERE `orders`.`customerNumber`=328
GROUP BY `orderdetails`.`orderNumber`;

/* Try it again with the France - French locale. */
SELECT `orderdetails`.`orderNumber`,
       FORMAT(SUM(`orderdetails`.`priceEach` * `quantityOrdered`),2,'fr_FR') AS `orderTotal`
FROM `orderdetails`
INNER JOIN (`orders`, `products`)
ON `orderdetails`.`orderNumber`=`orders`.`orderNumber` AND
   `products`.`productCode`=`orderdetails`.`productCode`
WHERE `orders`.`customerNumber`=328
GROUP BY `orderdetails`.`orderNumber`;

/* To see the default locale for the server. */
SELECT @@lc_time_names;

/* Let's select all the customers that are in either Sweden
or France.  We'll use the OR logical operator to do so. */
SELECT * FROM `customers`
WHERE `country`='Sweden' OR `country`='France';

/* This is the same query, but instead of OR we will
use IN. */
SELECT * FROM `customers`
WHERE `country` IN ('Sweden', 'France');

/* Let's select all the customers that are NOT in either of
Sweden or France. */
SELECT * FROM `customers`
WHERE `country` NOT IN ('Sweden', 'France');

/* Let's use that query as a subquery for another query.
Let's find all the customers with contact last names
starting with J that are not in either Sweeden or France. */
SELECT * FROM `customers`
WHERE `contactLastName` LIKE 'J%'
      AND `customerNumber` IN
          (SELECT customerNumber FROM `customers`
           WHERE `country` NOT IN ('Sweden', 'France'));

/* Note that in many cases, the main query and subquery
can be combined into one query.  For our last example,
we can do that. */
SELECT * FROM `customers`
WHERE `contactLastName` LIKE 'J%'
      AND `country` NOT IN ('Sweden', 'France');

/* Some customers don't have a value for state.
The value for no value is special and is called NULL.
Let's select all the customers that don't have a value
for state. */
SELECT * FROM `customers`
WHERE `state` IS NULL;

/* Let's use the COUNT() aggregate function to find
the number of customers with no state. */
SELECT COUNT(*) FROM `customers`
WHERE `state` IS NULL;

/* Let's insert a new row into the customer table.
But first we need to find the next avaliable customerNumber
since the table doesn't have auto-increment set on it.
We can order the numbers in descending order and only
select the very first one. */
SELECT `customerNumber` FROM `classicmodels.customers` ORDER BY `customerNumber` DESC LIMIT 1;

/* We got 496 for the highest customerNumber.  Let's use 497 then. */
INSERT INTO `classicmodels`.`customers`
(`customerNumber`,
`customerName`,
`contactLastName`,
`contactFirstName`,
`phone`,
`addressLine1`,
`addressLine2`,
`city`,
`state`,
`postalCode`,
`country`,
`salesRepEmployeeNumber`,
`creditLimit`)
VALUES
(497,
'ICS 325',
'Cross',
'Jason',
'999-999-9999',
'Some Street',
NULL,
'Minneapolis',
'MN',
55401,
'USA',
1370,
1000);

/* Let's take a look at the row we just inserted. */
SELECT * from `customers` WHERE `customerNumber`=497;

/* Let's change the credit limit for the customer we just
inserted from 1000 to 15000. We can use UPDATE to do that. */
UPDATE `classicmodels`.`customers`
SET `creditLimit` = 15000
WHERE `customerNumber` = 497;

/* Take a look at that row again to see that is has been updated */
SELECT * from `customers`
WHERE `customerNumber`=497;
