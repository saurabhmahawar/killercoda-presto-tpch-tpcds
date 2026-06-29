#!/bin/bash

# Pre-pull the PrestoDB Docker image in the background
# so the user doesn't wait during Step 1
docker pull prestodb/presto:latest

# Signal that the image is ready
touch /tmp/presto-ready
