#!/bin/bash

# Sample JSON-encoded map
json_string='{"admin_url": "value1"}'

# Parse JSON string and iterate over key-value pairs
#echo "$json_string" | jq -r 'to_entries[] | "\(.key) : \(.value)"'
echo -n '{"admin_url":"testurl"}'
