#response=$(curl -u Svc-ibs-core-sas:<+pipeline.variables.svc_pwd> -s -X GET https://artifactory.fis.dev/artifactory/ibsdo-maven-snapshot-local/com/fis/IBS/do/properties/)
#echo $response

#files=$(echo "$response"| grep -oP '(?<=href=")[^"]')
#echo "Files found:"
#echo "$files"

##########################################

#!/bin/bash

# Artifactory repository URL
REPO_URL="https://artifactory.fis.dev/artifactory/ibsdo-maven-snapshot-local/com/fis/IBS/do/properties/"
USERNAME="Svc-ibs-core-sas"
PASSWORD="<+pipeline.variables.svc_pwd>"

# Fetch the list of folders and their last updated timestamps
response=$(curl -s -u "$USERNAME:$PASSWORD" "${REPO_URL}?list&deep=1&listFolders=1")

# Print the raw response for debugging
echo "Raw response: $response"

# Parse the JSON response to get the latest updated folder
#latest_folder=$(echo "$response" | jq -r '.files | sort_by(.lastUpdated) | last | .uri')

# Extract folder names and dates
latest_folder=""
latest_date=""

while IFS= read -r line; do
  if [[ $line =~ href=\"([^\"]+)\" ]]; then
    folder=${BASH_REMATCH[1]}
  fi
  if [[ $line =~ ([0-9]{2}-[A-Za-z]{3}-[0-9]{4} [0-9]{2}:[0-9]{2}) ]]; then
    date=${BASH_REMATCH[1]}
    # Check if the folder matches the pattern MonYear.[0-9]-SNAPSHOT
    if [[ $folder =~ ^[A-Za-z]{3}[0-9]{4}\.[0-9]+-SNAPSHOT/$ ]]; then
      # Convert date to a comparable format
      date_epoch=$(date -d "$date" +%s)
      if [[ -z "$latest_date" || $date_epoch -gt $(date -d "$latest_date" +%s) ]]; then
        latest_date=$date
        latest_folder=${folder%/}  # Remove the trailing slash
      fi
    fi
  fi
done <<< "$response"

# Print the latest updated folder
echo "Latest updated folder: ${latest_folder}"

latest_updated_artifact=$latest_folder

echo "Latest updated artifact: ${latest_updated_artifact}"
