#! /bin/bash
read -p "Enter Shodan API Key: " API_KEY
read -p "Enter favicon URL: " fav
##hash
hash=$(curl -s -L -k $fav | python3 -c 'import mmh3,sys,codecs;print(mmh3.hash(codecs.encode(sys.stdin.buffer.read(),"base64")))')
##Hash Found
echo Generated Hash:$hash
##Runs shodan search and prints output
shodan_output=$(curl -s "https://api.shodan.io/shodan/host/search?key=$API_KEY&query=http.favicon.hash:$hash")
## Print Hosts obtained from search
host=$(echo "$shodan_output" | jq -r '.matches[].http.host')
echo "Hosts: $host"
