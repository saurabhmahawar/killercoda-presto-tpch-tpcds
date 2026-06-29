# Step 3: Connect to Presto CLI & Explore Catalogs

In this step, you will use the Presto CLI to explore the available catalogs, schemas, and tables.

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

List the active catalogs:

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

List the available schemas in the `tpch` catalog. The schemas correspond to scale factors that define the size of the generated dataset:

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

> **Note:** This scenario uses the `tiny` schema (SF 0.01) to run queries quickly within the container's resource limits.

## List TPC-H Tables

List the tables in the `tiny` schema:

```sql
SHOW TABLES FROM tpch.tiny;
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
SHOW TABLES FROM tpcds.tiny;
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

## Exit the CLI

Exit the Presto CLI:

```sql
quit;
```

Proceed to the next step to run queries against TPC-H data.

