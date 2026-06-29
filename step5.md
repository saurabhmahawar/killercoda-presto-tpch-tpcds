# Step 5: Query TPC-DS Data

In this step, you'll query the TPC-DS dataset — a retail store data model that is more complex than TPC-H, with 24 tables covering stores, customers, sales, items, and promotions.

## Connect to the Presto CLI

```bash
docker exec -it presto presto-cli --catalog tpcds --schema sf1
```

## Query 1: Browse Store Information

Let's start by looking at the stores in the dataset:

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

## Query 2: Explore the Item Catalog

Look at items available in the retail catalog:

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

## Query 3: Describe the Store Sales Table

The `store_sales` table is central to TPC-DS analytics:

```sql
DESCRIBE store_sales;
```

Notice the many fact-dimension relationships — `ss_item_sk`, `ss_customer_sk`, `ss_store_sk`, etc. These are foreign keys to dimension tables.

## Query 4: Count Store Sales Records

```sql
SELECT COUNT(*) AS total_store_sales FROM store_sales;
```

At scale factor 1, there are approximately **2.88 million** store sales records.

## Query 5: Top 10 Items by Sales Quantity

Find the best-selling items across all stores:

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

## Query 6: Sales by Store and State

Analyze store performance by geographic location:

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

## Query 7: Customer Demographics Analysis

TPC-DS includes rich demographic data. Let's analyze sales by customer demographics:

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

## Query 8: Cross-Channel Sales Comparison

One of TPC-DS's strengths is modeling multi-channel retail. Let's compare store vs. web sales:

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

This shows how retail data flows through three channels: **store**, **web**, and **catalog**.

## TPC-H vs TPC-DS: Quick Comparison

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

```sql
quit;
```

Congratulations! You've queried both TPC-H and TPC-DS datasets in PrestoDB!
