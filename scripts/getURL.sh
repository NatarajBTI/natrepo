#echo "$(<url.txt )"
echo "$(<url.txt )" | jq 'map(.)'
