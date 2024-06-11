response=$(curl -u Svc-RetirementDevops:<+secrets.getValue("org.rngartifactorysecret")> -s -X GET https://artifactory.fis.dev/artifactory/rcs-helm-release-local/)
echo $response
files=$(echo "$response"| grep -oP '(?<=href=")[^"]+\.tgz')
echo "Files found:"
echo "$files"

filter_files=$(echo "$files" | grep '^core-ivr-service')
echo "core-ivr-service file found:$filter_files"

version_files=$(echo "$filter_files" | grep "core-ivr-service-<+pipeline.variables.Major_version>\.")

latest_file=$(echo "$version_files" | sort -V | tail -n 1)
echo "Sorted result:$latest_file"

file_base_name=$(basename "$latest_file" .tgz)
#file_base_name=$(basename "$file_base_name" -SNAPSHOT)

echo "base name result:$file_base_name"

version=$(echo "$file_base_name" | grep -oP '\d+\.\d+\.\d+')
echo "Final major version result:$version"
echo "$version"
