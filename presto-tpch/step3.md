# Step 3: Connect to Presto CLI & Explore Catalogs

In this step, you'll use the Presto CLI to explore the available catalogs, schemas, and tables.

## Launch the Presto CLI

Connect to the Presto CLI inside the container:

```bash
docker exec -it presto presto-cli
```

You should see the Presto prompt:
```
presto>
```

## List Available Catalogs

Let's see all the catalogs that Presto has loaded:

```sql
SHOW CATALOGS;
```

Expected output:
```
 Catalog
---------
 jmx
 system
 tpcds
 tpch
(4 rows)
```

You can see `tpch` and `tpcds` are available along with `jmx` and the built-in `system` catalog.

## Explore TPC-H Schemas

Each catalog contains schemas. For TPC-H, schemas represent different **scale factors** — the size of the generated dataset:

```sql
SHOW SCHEMAS FROM tpch;
```

Expected output:
```
       Schema
--------------------
 information_schema
 sf1
 sf100
 sf1000
 sf10000
 sf100000
 sf300
 sf3000
 sf30000
 tiny
(10 rows)
```

| Schema | Description |
|--------|-------------|
| `tiny` | Very small dataset (~10 rows per table, great for quick tests) |
| `sf1`  | Scale factor 1 (~1 GB of data, good for learning) |
| `sf100` | Scale factor 100 (~100 GB of data) |
| `sf1000` | Scale factor 1000 (~1 TB of data) |

> **Tip:** For this tutorial, we'll use `sf1` — it has enough data to be meaningful but queries return quickly.

## List TPC-H Tables

Let's see what tables are available in the `sf1` schema:

```sql
SHOW TABLES FROM tpch.sf1;
```

Expected output:
```
  Table
----------
 customer
 lineitem
 nation
 orders
 part
 partsupp
 region
 supplier
(8 rows)
```

## Explore TPC-DS Schemas

Now let's do the same for TPC-DS:

```sql
SHOW SCHEMAS FROM tpcds;
```

You'll see similar scale factors. Let's list the TPC-DS tables:

```sql
SHOW TABLES FROM tpcds.sf1;
```

Expected output:
```
        Table
------------------------
 call_center
 catalog_page
 catalog_returns
 catalog_sales
 customer
 customer_address
 customer_demographics
 date_dim
 household_demographics
 income_band
 inventory
 item
 promotion
 reason
 ship_mode
 store
 store_returns
 store_sales
 time_dim
 warehouse
 web_page
 web_returns
 web_sales
 web_site
(24 rows)
```

Notice TPC-DS has **24 tables** compared to TPC-H's 8 — it's a much more complex data model representing a complete retail business.

## Exit the CLI (for now)

Exit the Presto CLI so we can continue with the tutorial steps:

```sql
quit;
```

Excellent! You've explored both catalogs. Next, let's run some real queries against TPC-H data!
