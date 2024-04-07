import json

# Create a dictionary with string keys and string values
data = {
    "admin_url": "value1"
}

# Encode the dictionary into JSON format
json_output = json.dumps(data)

# Print the JSON output
print(json_output)
