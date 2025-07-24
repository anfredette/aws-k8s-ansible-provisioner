#!/bin/bash

echo "=== Testing LLM-D Deployment ==="

# Find the most recent inventory file
INVENTORY_FILE=$(ls -rt gpu-inventory-*.ini 2>/dev/null | tail -1)

if [ -z "$INVENTORY_FILE" ]; then
    echo "Error: No inventory file found (gpu-inventory-*.ini)"
    echo "Make sure you have deployed the cluster first."
    exit 1
fi

echo "Using inventory file: $INVENTORY_FILE"
echo "Running LLM-D tests..."

ansible-playbook -i "$INVENTORY_FILE" llm-d-test.yaml

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ All tests passed!"
else
    echo ""
    echo "❌ Some tests failed."
    echo "This may be due to pods not being fully ready yet."
    echo "Wait a few minutes and try running this script again."
fi 