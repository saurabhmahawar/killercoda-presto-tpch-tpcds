# Step 1: Install & Start PrestoDB

In this step, you'll pull the official PrestoDB Docker image and start a Presto server with TPC-H and TPC-DS catalogs configured.

## Verify Docker is Available

First, let's confirm Docker is running in your environment:

```bash
docker --version
```

You should see the Docker version output.

## Prepare the Catalog Configuration

The TPC-H and TPC-DS catalog configuration files have already been placed in your home directory by the scenario setup. Let's create a proper catalog directory and copy them:

```bash
mkdir -p ~/presto-catalog
cp ~/tpch.properties ~/presto-catalog/
cp ~/tpcds.properties ~/presto-catalog/
cp ~/jmx.properties ~/presto-catalog/
```

Let's verify the catalog files are in place:

```bash
ls -la ~/presto-catalog/
```

You should see three files: `tpch.properties`, `tpcds.properties`, and `jmx.properties`.

## Start the PrestoDB Container

Now, start PrestoDB with the catalog directory mounted:

```bash
docker run -d \
  --name presto \
  -p 8080:8080 \
  -v ~/presto-catalog:/opt/presto-server/etc/catalog \
  prestodb/presto:latest
```

This command:
- Runs Presto in detached mode (`-d`)
- Names the container `presto`
- Exposes port `8080` for the Presto Web UI
- Mounts your catalog configuration into the container

## Wait for Presto to Start

Presto takes a few seconds to initialize. Let's wait for it to be ready:

```bash
echo "Waiting for Presto to start..."
until docker exec presto presto-cli --execute "SELECT 1" &>/dev/null; do
  sleep 2
  echo "  Still waiting..."
done
echo "✅ PrestoDB is ready!"
```

## Verify the Container is Running

```bash
docker ps --filter name=presto
```

You should see the `presto` container in a `healthy` or `running` state.

Great! PrestoDB is now up and running. Let's move on to exploring the catalogs.
