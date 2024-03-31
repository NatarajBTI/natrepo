#echo "$(<url.txt )"
#jq '.' url.txt
cat url.txt | sed -e 's/\\\"/\"/g' -e 's/^.//g' -e 's/.$//g'
