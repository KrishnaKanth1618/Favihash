#! /bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
read -p "${GREEN}Enter Shodan API Key: " API_KEY
read -p "${GREEN}Enter favicon URL: " fav
##Generate hash
hash=$(curl -s -L -k $fav | python3 -c 'import mmh3,sys,codecs;print(mmh3.hash(codecs.encode(sys.stdin.buffer.read(),"base64")))')
##Hash Found
echo Generated Hash:$hash
##Runs shodan search and prints output
shodan_output=$(curl -s "https://api.shodan.io/shodan/host/search?key=$API_KEY&query=http.favicon.hash:$hash")
## Print Hosts obtained from search
host=$(echo "$shodan_output" | jq -r '.matches[].http.host')
echo "${RED}Hosts: $host"
