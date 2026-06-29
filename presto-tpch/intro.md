# Welcome to PrestoDB: Querying TPC-H & TPC-DS Data 🚀

In this hands-on scenario, you'll learn how to deploy **PrestoDB** using Docker and run SQL queries against two industry-standard benchmark datasets: **TPC-H** and **TPC-DS**.

## What is PrestoDB?

[PrestoDB](https://prestodb.io/) is an open-source distributed SQL query engine designed for running interactive analytic queries against data sources of all sizes — from gigabytes to petabytes. It allows you to query data where it lives, including Hive, Cassandra, relational databases, and even flat files.

## What are TPC-H and TPC-DS?

- **TPC-H** (Transaction Processing Performance Council - Ad Hoc) is a decision support benchmark. It consists of a suite of business-oriented queries that examine large volumes of data, execute queries with a high degree of complexity, and answer critical business questions. It models a parts supplier database.

- **TPC-DS** (Transaction Processing Performance Council - Decision Support) is a more complex decision support benchmark that models a retail product supplier. It includes more tables, more complex queries, and represents a broader range of decision support workloads than TPC-H.

Both connectors in Presto **generate data on the fly** — no external database or data loading is required!

## What You'll Learn

1. 🐳 Deploy PrestoDB using Docker
2. ⚙️ Configure TPC-H and TPC-DS catalog connectors
3. 🔍 Explore catalogs, schemas, and tables using the Presto CLI
4. 📊 Run TPC-H benchmark queries (parts supplier data)
5. 🏪 Run TPC-DS benchmark queries (retail store data)

## Prerequisites

- Basic SQL knowledge
- No local setup needed — everything runs in this browser-based environment!

**Estimated time:** ~15 minutes

Let's get started!
