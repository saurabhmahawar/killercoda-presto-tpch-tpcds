# Step 1: Deploy PrestoDB

In this step, you will start a PrestoDB server using Docker with catalog configurations for TPC-H and TPC-DS.

## Verify Docker is Available

Confirm Docker is running in your environment:

```bash
docker --version
```

You should see the Docker version details.

## Prepare the Catalog Directory

The TPC-H and TPC-DS catalog properties files have been written to `/root/` by the background setup. Create a catalog directory and copy these files:

```bash
mkdir -p ~/presto-catalog
cp ~/tpch.properties ~/presto-catalog/
cp ~/tpcds.properties ~/presto-catalog/
cp ~/jmx.properties ~/presto-catalog/
```

Verify that the files are present in the directory:

```bash
ls -la ~/presto-catalog/
```

You should see the following files: `tpch.properties`, `tpcds.properties`, and `jmx.properties`.

## Run the PrestoDB Container

Start the PrestoDB container with the catalog directory mounted:

```bash
docker run -d \
  --name presto \
  -p 8080:8080 \
  -v ~/presto-catalog:/opt/presto-server/etc/catalog \
  prestodb/presto:latest
```

This command runs the container in the background, maps port 8080, and mounts your local catalog files to Presto's configuration directory.

## Wait for Presto to Start

Wait for the Presto service to initialize:

```bash
echo "Waiting for Presto to start..."
until docker exec presto presto-cli --execute "SELECT 1" &>/dev/null; do
  sleep 2
  echo "  Still waiting..."
done
echo "PrestoDB is ready!"
```

## Verify the Container Status

Check the status of the container:

```bash
docker ps --filter name=presto
```

The container should show a status of "Up".

Proceed to the next step to explore the configured catalogs.

