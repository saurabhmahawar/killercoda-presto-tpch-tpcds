# Scenario Completed

You have completed the scenario for querying TPC-H and TPC-DS data in PrestoDB.

## Tasks Completed

*   Deployed PrestoDB using Docker.
*   Configured TPC-H and TPC-DS catalog connectors.
*   Explored available catalogs, schemas, and tables via the Presto CLI.
*   Executed analytical queries against the TPC-H parts supplier dataset.
*   Executed analytical queries against the TPC-DS multi-channel retail dataset.
*   Compared the structural differences between TPC-H and TPC-DS models.

## Key Concepts

1.  **Schema-on-Read**: Presto does not store data directly. It queries data sources in-place through configured connectors.
2.  **Built-in Benchmarking**: The TPC-H and TPC-DS connectors generate data on the fly. This provides a self-contained environment for learning SQL and testing query behavior without setting up external databases.
3.  **Scale Factors**: You can adjust the dataset size using different schemas, from `tiny` (scale factor 0.01) for functional tests to larger scale factors for performance benchmarking.

## Join the Community

To learn more about Presto and get support, join the PrestoDB community:

*   **Presto Slack Workspace**: [Join Presto Slack](https://communityinviter.com/apps/prestodb/prestodb)
*   **Documentation**: [PrestoDB Documentation](https://prestodb.io/docs/current/)

## Clean Up

To stop and remove the Presto container from the terminal:

```bash
docker stop presto && docker rm presto
```

