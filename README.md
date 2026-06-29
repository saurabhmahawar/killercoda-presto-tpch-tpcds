# PrestoDB: TPC-H & TPC-DS KillerCoda Scenario

This repository contains the configuration, instructions, and scripts for a KillerCoda interactive scenario that teaches users how to deploy PrestoDB and run analytical SQL queries against the TPC-H and TPC-DS benchmark datasets.

## Scenario Overview

*   **Platform**: [KillerCoda](https://killercoda.com/)
*   **Target Backend**: Ubuntu with Docker pre-installed.
*   **Presto Engine**: Official `prestodb/presto` Docker image.
*   **Datasets**: Presto's built-in `tpch` and `tpcds` connectors using the `tiny` schema scale factor to optimize execution speed within resource-constrained environments.

## Repository Structure

```
.
├── README.md                  # Project documentation
└── presto-tpch/               # KillerCoda scenario directory
    ├── index.json             # Scenario metadata & configuration
    ├── intro.md               # Scenario introduction page
    ├── step1.md               # Step 1: Deploy PrestoDB container
    ├── step2.md               # Step 2: Verify PrestoDB & access Web UI
    ├── step3.md               # Step 3: Connect via CLI & explore schemas
    ├── step4.md               # Step 4: Run TPC-H queries
    ├── step5.md               # Step 5: Run TPC-DS queries
    ├── finish.md              # Scenario completion page
    ├── setup.sh               # Background initialization script
    ├── foreground.sh          # Foreground terminal preparation script
    └── assets/                # Assets directory (TPC properties files)
        ├── jmx.properties
        ├── tpcds.properties
        └── tpch.properties
```

## How it Works

1.  **Environment Setup**: When the scenario starts, `setup.sh` runs in the background to write the Presto catalog property configurations to `/root/` and pre-pull the PrestoDB image.
2.  **Terminal Initialization**: `foreground.sh` calls the background-generated `wait.sh` script to monitor Presto readiness, enforce a 5-minute timeout guard, and clear the screen once the container is ready.
3.  **Scenario Steps**: The markdown pages (`step1.md` to `step5.md`) guide the user through catalog verification, CLI access, and query execution against the benchmark schemas.

## How to Deploy on KillerCoda

1.  Create a Creator Profile on [KillerCoda](https://killercoda.com/creators).
2.  Link this repository (`saurabhmahawar/killercoda-presto-tpch-tpcds`) and branch (`main`) in the Creator Dashboard.
3.  Add the KillerCoda deploy key and webhook URL in your GitHub Repository settings to enable automatic scenario redeployment on push.
