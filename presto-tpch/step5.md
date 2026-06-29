# Step 5: Query TPC-DS Data

In this step, you will run analytical SQL queries against the TPC-DS multi-channel retail dataset.

## Connect to the Presto CLI

Connect to the CLI targeting the `tpcds` catalog and `tiny` schema:

```bash
docker exec -it presto presto-cli --catalog tpcds --schema tiny
```

## Query 1: Retrieve Store Details

Retrieve basic information about retail stores:

```sql
SELECT
    s_store_id,
    s_store_name,
    s_city,
    s_state,
    s_number_employees
FROM store
LIMIT 10;
```

## Query 2: Retrieve Catalog Items

View items available in the retail catalog:

```sql
SELECT
    i_item_id,
    i_item_desc,
    i_category,
    i_class,
    i_current_price
FROM item
LIMIT 10;
```

## Query 3: Inspect Store Sales Table Structure

Inspect the columns and data types of the `store_sales` table:

```sql
DESCRIBE store_sales;
```

Note the foreign key relationships such as `ss_item_sk`, `ss_customer_sk`, and `ss_store_sk` linking fact records to dimensions.

## Query 4: Count Store Sales Records

Count the total transactions in the `store_sales` table:

```sql
SELECT COUNT(*) AS total_store_sales FROM store_sales;
```

At the tiny scale factor, this returns approximately **28,800** records.

## Query 5: Retrieve Top 10 Items by Sales Quantity

Identify the best-selling items across all stores:

```sql
SELECT
    i.i_item_id,
    i.i_item_desc,
    i.i_category,
    SUM(ss.ss_quantity) AS total_quantity,
    ROUND(SUM(ss.ss_net_paid), 2) AS total_revenue
FROM store_sales ss
JOIN item i ON ss.ss_item_sk = i.i_item_sk
GROUP BY i.i_item_id, i.i_item_desc, i.i_category
ORDER BY total_quantity DESC
LIMIT 10;
```

## Query 6: Calculate Store Performance by State

Calculate store sales metrics and average transaction values grouped by state:

```sql
SELECT
    s.s_store_name,
    s.s_state,
    COUNT(*) AS total_transactions,
    ROUND(SUM(ss.ss_net_paid), 2) AS total_revenue,
    ROUND(AVG(ss.ss_net_paid), 2) AS avg_transaction
FROM store_sales ss
JOIN store s ON ss.ss_store_sk = s.s_store_sk
GROUP BY s.s_store_name, s.s_state
ORDER BY total_revenue DESC
LIMIT 10;
```

## Query 7: Analyze Store Sales by Demographics

Analyze sales metrics grouped by customer demographics (gender, marital status, education):

```sql
SELECT
    cd.cd_gender,
    cd.cd_marital_status,
    cd.cd_education_status,
    COUNT(*) AS purchase_count,
    ROUND(SUM(ss.ss_net_paid), 2) AS total_spent
FROM store_sales ss
JOIN customer_demographics cd ON ss.ss_cdemo_sk = cd.cd_demo_sk
GROUP BY cd.cd_gender, cd.cd_marital_status, cd.cd_education_status
ORDER BY total_spent DESC
LIMIT 10;
```

## Query 8: Compare Multi-Channel Sales

Compare transaction counts and total net revenue across store, web, and catalog channels:

```sql
SELECT 'Store Sales' AS channel, COUNT(*) AS transactions, ROUND(SUM(ss_net_paid), 2) AS revenue
FROM store_sales
UNION ALL
SELECT 'Web Sales' AS channel, COUNT(*) AS transactions, ROUND(SUM(ws_net_paid), 2) AS revenue
FROM web_sales
UNION ALL
SELECT 'Catalog Sales' AS channel, COUNT(*) AS transactions, ROUND(SUM(cs_net_paid), 2) AS revenue
FROM catalog_sales;
```

## Dataset Comparison

The following table summarizes the structural differences between TPC-H and TPC-DS:

| Feature | TPC-H | TPC-DS |
|---------|-------|--------|
| **Tables** | 8 | 24 |
| **Focus** | Parts supplier | Retail store |
| **Channels** | Single | Multi-channel (store, web, catalog) |
| **Complexity** | Moderate | High |
| **Demographics** | No | Yes |
| **Returns** | No | Yes (store_returns, web_returns, catalog_returns) |
| **Use Case** | Ad-hoc analytics | Decision support |

## Exit the CLI

Exit the Presto CLI session:

```sql
quit;
```

