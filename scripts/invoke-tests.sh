#!/bin/bash

echo "Invoking API..."
curl -s https://your-global-endpoint.com

echo "Starting FIS experiment..."
aws fis start-experiment --id $1
