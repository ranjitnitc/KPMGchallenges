#!/bin/bash

function get_metadata() {
    local prefix="$1"
    curl -s "http://169.254.169.254/latest/meta-data/$prefix" | while read line; do
        local key="$line"
        local value="$(curl -s "http://169.254.169.254/latest/meta-data/$key")"
        if [[ -z "$value" && "$value" == *"/"* ]]; then
            # This is a folder, recursively fetch its contents
            get_metadata "$key"
        else
            # This is a value, output it as key-value pair
            echo "\"$key\": \"$value\","
        fi
    done
}

echo "{"
get_metadata ""

# Remove the trailing comma and wrap the output in an object
echo "}" | jq -s '.[0] + {metadata: '$(cat -)'}' 