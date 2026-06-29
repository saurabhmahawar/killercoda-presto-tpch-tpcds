# Step 2: Configure TPC-H & TPC-DS Catalogs

In this step, you will inspect how Presto catalogs are configured and verify the setup.

## Understanding Presto Catalogs

In Presto, a **catalog** is a connector configuration that defines how Presto accesses a data source. Catalogs are configured via `.properties` files in the `etc/catalog/` directory.

Each catalog file specifies the connector name and any connector-specific properties.

## Inspect the Catalog Files

View the configuration files:

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

**JMX Catalog (Used for system monitoring):**

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

> **Note:** The TPC-H and TPC-DS connectors do not connect to an external database. Instead, they generate data on the fly based on the scale factor you choose. This makes them ideal for learning and testing query performance.

## Verify Catalogs are Mounted

Verify the files are mounted inside the container:

```bash
docker exec presto ls -la /opt/presto-server/etc/catalog/
```

You should see all three `.properties` files listed in the output.

Proceed to the next step to connect to the Presto CLI.

