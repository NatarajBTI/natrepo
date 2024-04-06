#!/bin/bash

# Sample JSON-encoded map
json_string='{"admin_url": "value1"}'

# Parse JSON string and iterate over key-value pairs
#echo "$json_string" | jq -r 'to_entries[] | "\(.key) : \(.value)"'
echo -n '{"admin_url":"https://admin.natinst3.masdaub05-workload-cluste-6f1620198115433da1cac8216c06779b-0000.eu-de.containers.appdomain.cloud"}'
