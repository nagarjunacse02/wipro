# Introduction : This script is needed to extract version numbers for multiple services from given result based on user input and store each version in a seperate variable for further use.
# Example : if a user input 2024.1 for Helloworld named service(file), script will filter file Helloworld with 2024.1 (Like 2024.1.1, 2024.1.2, 2024.1.3) then it will filter latest patch version of service Helloworld (in this case 2024.1.3) and store it in variable

# Lets look into the each step in detail
# -----------------------------------------------------------------------------------------------------------------------------------------------------


# step 1: Get all the list of files in the below mentioned directory in HTML format
response=$(curl -u Svc-RetirementDevops:<+secrets.getValue("org.rngartifactorysecret")> -s -X GET https://artifactory.fis.dev/artifactory/rcs-helm-release-local/)
echo $response

#step 2: File patterns to filter
file_patterns=("admin-gateway-service"
"admin-master-service"
"avrio-gds-service-fund"
"avrio-infra-service-configuration")

# step 3: Extract all .tgz filenames from the HTML Response (Used grep to find lines with .tgz)
filtered_files=$(echo "$response"| grep -oP '(?<=href=")[^"]+\.tgz')
echo "Files found:"
echo "$filtered_files"

# step 4: Further filter to include only above mentioned file patterns
filtered_specific_files=""
for pattern in "${file_patterns[@]}";
do
    filtered_specific_files+=$(echo "$filtered_files" | grep "^$pattern")
    filtered_specific_files+=$'\n'
done

echo "Filtered files specific pattern"
echo "$filtered_specific_files"

#Initialize an associative array to store version filtered files for each pattern
declare -A version_filtered_files

# step 5: Loop over each file pattern and Filter files based on user input major version.
#version_filtered_files=""
for pattern in "${file_patterns[@]}";
do
   version_files=$(echo "$filtered_specific_files" | grep "$pattern-<+pipeline.variables.Major_version>\.")
   version_filtered_files[$pattern]="$version_files"
   #version_filtered_files+="$version_files"$'\n'
   #echo "$version_files"
done 

# Display the filtered results for each pattern
echo "Filtered file version '$<+pipeline.variables.Major_version>':"
for pattern in "${file_patterns[@]}";
do
   echo "Files $pattern:"
   echo "${version_filtered_files[$pattern]}"
   echo
done

# step 6: Initialize variables to store version numbers for each service
latest_admin_gateway_service=""
latest_admin_master_service=""
latest_avrio_gds_service_fund=""
latest_avrio_infra_service_configuration=""

# step 7: Find the latest version for each pattern and remove the .tgz extension using basename
echo "Latest version files:"
for pattern in "${file_patterns[@]}";
do
   latest_file=$(echo "${version_filtered_files[$pattern]}" | sort -V | tail -n 1)
   file_base_name=$(basename "$latest_file" .tgz)
   version=$(echo "$file_base_name" | grep -oP '\d+\.\d+\.\d+')
   #step 8: Assign version number to corresponding variable based on service name(This is required because we need to take out every version from this shell script step and use in as input to helm service runtime input)
   case $pattern in 
      "admin-gateway-service")
         latest_admin_gateway_service="$version"
         ;;
      "admin-master-service")
         latest_admin_master_service="$version"
         ;;
       "avrio-gds-service-fund")
         latest_avrio_gds_service_fund="$version"
         ;;
      "avrio-infra-service-configuratione")
         latest_avrio_infra_service_configuration="$version"
         ;;
   esac
done

#print the latest versions of all the services
echo "latest_admin_gateway_service version: $latest_admin_gateway_service"
echo "latest_admin_master_service version: $latest_admin_master_service"
echo "latest_avrio_gds_service_fund version: $latest_avrio_gds_service_fund"
echo "latest_avrio_infra_service_configuration version: $latest_avrio_infra_service_configuration"
