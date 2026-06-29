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

# Create the wait script that foreground.sh will execute
# (This prevents a wall of bash code from typing out in the user's terminal)
cat << 'EOF' > /usr/local/bin/wait.sh
#!/bin/bash
clear
echo "Preparing your PrestoDB environment... (pulling Docker image)"
TIMEOUT=300
ELAPSED=0
while [ ! -f /tmp/presto-ready ]; do
  sleep 2
  ELAPSED=$((ELAPSED + 2))
  if [ $ELAPSED -ge $TIMEOUT ]; then
    echo "Error: Setup timed out after ${TIMEOUT}s."
    echo "Check Docker pull status: docker logs presto"
    exit 1
  fi
done
clear
echo "Environment ready! Follow the steps to get started."
EOF
chmod +x /usr/local/bin/wait.sh

# Pre-pull the PrestoDB Docker image in the background
# so the user doesn't wait during Step 1
docker pull prestodb/presto:latest

# Signal that the image is ready
touch /tmp/presto-ready
