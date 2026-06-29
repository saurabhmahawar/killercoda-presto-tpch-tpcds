#!/bin/bash

echo "⏳ Preparing your PrestoDB environment... (pulling Docker image)"
while [ ! -f /tmp/presto-ready ]; do sleep 1; done
clear
echo "✅ Environment ready! Follow the steps to get started."

