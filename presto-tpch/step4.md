# Step 4: Query TPC-H Data

In this step, you'll run SQL queries against the TPC-H dataset — a parts supplier data model commonly used for analytical benchmarking.

## Connect to the Presto CLI

```bash
docker exec -it presto presto-cli --catalog tpch --schema tiny
```

This connects you directly to the `tpch` catalog and `tiny` schema, so you don't need to fully qualify table names.

## Query 1: List All Nations

Start with a simple query to see all nations in the TPC-H dataset:

```sql
SELECT * FROM nation;
```

This returns 25 rows — one for each nation in the benchmark dataset.

## Query 2: List All Regions

```sql
SELECT * FROM region;
```

TPC-H defines 5 regions: AFRICA, AMERICA, ASIA, EUROPE, and MIDDLE EAST.

## Query 3: Count Customers

How many customers are in the `tiny` dataset?

```sql
SELECT COUNT(*) AS total_customers FROM customer;
```

At the tiny scale factor, you should see **1,500 customers**.

## Query 4: Describe Table Structure

Let's look at the structure of the `orders` table:

```sql
DESCRIBE orders;
```

This shows all columns, their data types, and other metadata.

## Query 5: Top 10 Customers by Account Balance

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

## Query 6: Order Count by Status

Analyze the distribution of order statuses:

```sql
SELECT
    orderstatus,
    COUNT(*) AS order_count,
    ROUND(AVG(totalprice), 2) AS avg_price
FROM orders
GROUP BY orderstatus
ORDER BY order_count DESC;
```

## Query 7: Revenue by Nation (Top 10)

This is a classic TPC-H analytical query — calculate total revenue per nation using joins across multiple tables:

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

This query joins **lineitem → orders → customer → nation** to compute total revenue per nation — a common analytical pattern.

## Query 8: Monthly Revenue Trend

Analyze revenue trends over time:

```sql
SELECT
    YEAR(o.orderdate) AS order_year,
    MONTH(o.orderdate) AS order_month,
    COUNT(*) AS total_orders,
    ROUND(SUM(o.totalprice), 2) AS total_revenue
FROM orders o
GROUP BY YEAR(o.orderdate), MONTH(o.orderdate)
ORDER BY order_year, order_month
LIMIT 20;
```

## Exit the CLI

```sql
quit;
```

You've just run analytical queries on TPC-H data! Next, let's explore the TPC-DS dataset.
