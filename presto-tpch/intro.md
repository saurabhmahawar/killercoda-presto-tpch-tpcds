<center>
  <img src="./assets/presto-logo.png" width="260" alt="Presto Logo" />
</center>

This scenario provides a hands-on guide to deploying PrestoDB and running SQL queries against the industry-standard TPC-H and TPC-DS benchmark datasets.

## PrestoDB Overview

[PrestoDB](https://prestodb.io/) is an open-source distributed SQL query engine designed for running interactive analytic queries against data sources of all sizes. It allows you to query data where it lives, including Hive, Cassandra, relational databases, and object stores.

## Benchmark Datasets

*   **TPC-H**: Models a parts supplier database. It consists of business-oriented ad-hoc queries that examine large volumes of data with high execution complexity.
*   **TPC-DS**: Models a multi-channel retail business (stores, web, catalog). It is a more complex decision support benchmark with a larger number of tables and relationships.

Both connectors in Presto generate data on the fly, eliminating the need to install or configure external databases.

## Objectives

1. Deploy PrestoDB using Docker.
2. Configure TPC-H and TPC-DS catalog connectors.
3. Explore schemas and tables using the Presto CLI.
4. Run analytical queries against TPC-H and TPC-DS data.

## Prerequisites

*   Basic SQL knowledge.
*   No local setup is required — the environment is fully provisioned in this browser session.

