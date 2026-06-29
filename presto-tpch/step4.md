# Step 4: Query TPC-H Data

In this step, you will run analytical SQL queries against the TPC-H parts supplier dataset.

## Connect to the Presto CLI

Connect to the CLI targeting the `tpch` catalog and `tiny` schema:

```bash
docker exec -it presto presto-cli --catalog tpch --schema tiny
```

This sets the active catalog and schema for your session so you do not need to fully qualify table names in your queries.

## Query 1: Retrieve All Nations

Retrieve all records from the `nation` table:

```sql
SELECT * FROM nation;
```

The query returns 25 rows, representing the default nations defined in the TPC-H benchmark.

## Query 2: Retrieve All Regions

```sql
SELECT * FROM region;
```

This returns the 5 default regions: AFRICA, AMERICA, ASIA, EUROPE, and MIDDLE EAST.

## Query 3: Count Customers

Count the total number of customers in the `tiny` dataset:

```sql
SELECT COUNT(*) AS total_customers FROM customer;
```

At the tiny scale factor (SF 0.01), this query returns **1,500**.

## Query 4: View Table Structure

Inspect the columns and data types of the `orders` table:

```sql
DESCRIBE orders;
```

## Query 5: Retrieve Top 10 Customers by Account Balance

Identify the top 10 customers with the highest account balance:

```sql
SELECT
    c.name,
    c.acctbal AS account_balance,
    n.name AS nation
FROM customer c
JOIN nation n ON c.nationkey = n.nationkey
ORDER BY c.acctbal DESC
LIMIT 10;
```

## Query 6: Calculate Order Counts by Status

Analyze the distribution of order statuses and average total price:

```sql
SELECT
    orderstatus,
    COUNT(*) AS order_count,
    ROUND(AVG(totalprice), 2) AS avg_price
FROM orders
GROUP BY orderstatus
ORDER BY order_count DESC;
```

## Query 7: Calculate Revenue by Nation (Top 10)

This query joins the `lineitem`, `orders`, `customer`, and `nation` tables to compute total revenue per nation:

```sql
SELECT
    n.name AS nation,
    COUNT(DISTINCT o.orderkey) AS total_orders,
    ROUND(SUM(l.extendedprice * (1 - l.discount)), 2) AS revenue
FROM lineitem l
JOIN orders o ON l.orderkey = o.orderkey
JOIN customer c ON o.custkey = c.custkey
JOIN nation n ON c.nationkey = n.nationkey
GROUP BY n.name
ORDER BY revenue DESC
LIMIT 10;
```

## Query 8: Group and Order Monthly Revenue

Analyze monthly revenue trends by extracting the year and month from the order date:

```sql
SELECT
    EXTRACT(YEAR FROM o.orderdate) AS order_year,
    EXTRACT(MONTH FROM o.orderdate) AS order_month,
    COUNT(*) AS total_orders,
    ROUND(SUM(o.totalprice), 2) AS total_revenue
FROM orders o
GROUP BY EXTRACT(YEAR FROM o.orderdate), EXTRACT(MONTH FROM o.orderdate)
ORDER BY order_year, order_month
LIMIT 20;
```

## Exit the CLI

Exit the Presto CLI session:

```sql
quit
```

Proceed to the next step to query the TPC-DS dataset.

