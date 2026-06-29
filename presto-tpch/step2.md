# Step 2: Verify PrestoDB & Access Web UI

In this step, you will verify that the Presto catalogs are loaded correctly and access the Presto Web UI to inspect the cluster status.

## Verify Mounted Catalogs

Confirm that your catalog properties files are mounted inside the container's configuration directory:

```bash
docker exec presto ls -la /opt/presto-server/etc/catalog/
```

You should see the following files in the output:
*   `tpch.properties`
*   `tpcds.properties`
*   `jmx.properties`

These configurations instruct PrestoDB to load the corresponding connectors.

## Access the Presto Web UI

PrestoDB includes a built-in web dashboard for monitoring queries and cluster resources. Since port `8080` was exposed when starting the container, you can access the dashboard directly.

Open the Presto Web UI in your browser:
*   [Access Presto Web UI](https://{{TRAFFIC_HOST1_8080}})
*   *Alternatively, you can open the **Traffic/Ports** menu in the top-right corner of the KillerCoda interface and select port `8080`.*

## Explore the Dashboard

The dashboard provides real-time information about your Presto server:

1.  **Cluster State**: At the top, you will see the number of active worker nodes, running queries, and total memory usage. Since we are running a single-node setup, the active worker count will be `1`.
2.  **Query History**: The main table lists all executed queries, their SQL statements, execution status, and resource consumption.
3.  **Active Queries**: If a query is currently running, you can click on its ID to view the physical execution plan, stage breakdown, and operator-level statistics.

Leave the Web UI tab open in your browser. As you run SQL queries in the next steps, you can refresh this dashboard to monitor their progress and performance metrics.

Proceed to the next step to connect to the Presto CLI.
