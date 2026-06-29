#!/bin/bash

# Create the properties files in /root/ directly using bash
# (This bypasses any potential KillerCoda asset copy/path resolution issues)
cat << 'EOF' > /root/tpch.properties
connector.name=tpch
EOF

cat << 'EOF' > /root/tpcds.properties
connector.name=tpcds
EOF

cat << 'EOF' > /root/jmx.properties
connector.name=jmx
EOF

# Pre-pull the PrestoDB Docker image in the background
# so the user doesn't wait during Step 1
docker pull prestodb/presto:latest

# Signal that the image is ready
touch /tmp/presto-ready

