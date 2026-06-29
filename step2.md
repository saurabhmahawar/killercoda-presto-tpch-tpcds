# Step 2: Configure TPC-H & TPC-DS Catalogs

In this step, you'll understand how Presto catalogs work and verify that TPC-H and TPC-DS are properly configured.

## Understanding Presto Catalogs

In Presto, a **catalog** is a connector configuration that defines how Presto accesses a data source. Catalogs are configured via `.properties` files in the `etc/catalog/` directory.

Each catalog file is simple — it specifies the connector name and any connector-specific properties.

## Inspect the Catalog Files

Let's look at what we configured:

**TPC-H Catalog:**

```bash
cat ~/presto-catalog/tpch.properties
```

Output:
```
connector.name=tpch
```

**TPC-DS Catalog:**

```bash
cat ~/presto-catalog/tpcds.properties
```

Output:
```
connector.name=tpcds
```

**JMX Catalog (bonus — for monitoring):**

```bash
cat ~/presto-catalog/jmx.properties
```

Output:
```
connector.name=jmx
```

## How These Connectors Work

| Connector | Description | Data Model |
|-----------|-------------|------------|
| **tpch**  | TPC-H benchmark data generator | Parts supplier (customers, orders, line items, suppliers, nations, regions) |
| **tpcds** | TPC-DS benchmark data generator | Retail store (stores, customers, sales, items, promotions, warehouses) |
| **jmx**   | Java Management Extensions | Exposes JVM and Presto internal metrics |

> **Key insight:** The TPC-H and TPC-DS connectors don't connect to an external database. They **generate data on the fly** based on the scale factor you choose. This makes them perfect for learning and benchmarking!

## Verify Catalogs are Loaded Inside the Container

Let's confirm the files are correctly mounted inside the running container:

```bash
docker exec presto ls -la /opt/presto-server/etc/catalog/
```

You should see all three `.properties` files listed.

Catalogs are configured and loaded. Next, let's connect to the Presto CLI and explore them!
