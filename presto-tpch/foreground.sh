#!/bin/bash

echo "Preparing your PrestoDB environment... (pulling Docker image)"

TIMEOUT=300
ELAPSED=0

while [ ! -f /tmp/presto-ready ]; do
  sleep 2
  ELAPSED=$((ELAPSED + 2))
  if [ $ELAPSED -ge $TIMEOUT ]; then
    echo "Error: Setup timed out. Please restart the scenario."
    exit 1
  fi
done

clear
echo "Environment ready! Follow the steps to get started."
