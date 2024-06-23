# Introduction : This script is needed to extract version numbers for multiple services from given result based on user input and store each version in a seperate variable for further use.
# Example : if a user input 2024.1 for Helloworld named service(file), script will filter file Helloworld with 2024.1 (Like 2024.1.1, 2024.1.2, 2024.1.3) then it will filter latest patch version of service Helloworld (in this case 2024.1.3) and store it in variable

# Lets look into the each step in detail
# -----------------------------------------------------------------------------------------------------------------------------------------------------


# step 1: Get all the list of files in the below mentioned directory in HTML format
response=$(curl -u Svc-RetirementDevops:<+secrets.getValue("org.rngartifactorysecret")> -s -X GET https://artifactory.fis.dev/artifactory/rcs-helm-snapshot-local/)
echo $response

#step 2: File patterns to filter
file_patterns=("infra-configuration-service"
"core-annuities-service"
"core-business-service"
"core-defined-benefit-service"
"core-gateway-service"
"core-general-processing-service"
"core-investments-service"
"core-loan-service"
"core-money-in-service"
"core-money-out-service"
"core-packet-service"
"core-participant-service"
"core-plans-service"
"core-security-service"
"core-textfile-service"
"core-trade-service"
"core-transaction-service"
"infra-cache-service"
"core-utilities-service")

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
   version_files=$(echo "$filtered_specific_files" | grep "$pattern")
   #if [[ -z "$version_files" ]]; then
      #echo "Error: No chart found for '$pattern' with version '<+pipeline.variables.Major_version>'"
	  #exit 1
   #fi	  
   version_filtered_files[$pattern]="$version_files"
   #version_filtered_files+="$version_files"$'\n'
   #echo "$version_files"
done 

# Display the filtered results for each pattern
#echo "Filtered file version '$<+pipeline.variables.Major_version>':"
for pattern in "${file_patterns[@]}";
do
   echo "Files $pattern:"
   echo "${version_filtered_files[$pattern]}"
   echo
done

# step 6: Initialize variables to store version numbers for each service
latest_infra_configuration_service=""
latest_core_annuities_service=""
latest_core_business_service=""     
latest_core_defined_benefit_service=""
latest_core_gateway_service=""
latest_core_general_processing_service=""
latest_core_investments_service=""     
latest_core_loan_service=""     
latest_core_money_in_service=""
latest_core_money_out_service=""
latest_core_packet_service=""
latest_core_participant_service=""
latest_core_plans_service=""     
latest_core_security_service=""
latest_core_textfile_service=""
latest_core_trade_service=""
latest_core_transaction_service=""     
latest_infra_cache_service=""     
latest_core_utilities_service=""


# step 7: Find the latest version for each pattern and remove the .tgz extension using basename
echo "Latest version files:"
for pattern in "${file_patterns[@]}";
do
   latest_file=$(echo "${version_filtered_files[$pattern]}" | sort -V | tail -n 1)
   echo "The latest file is : $latest_file"
   file_base_name=$(basename "$latest_file" .tgz)
   version=$(echo "$file_base_name" | grep -oP '\d+(\.\d+){1,2}(-SNAPSHOT)?')
   #step 8: Assign version number to corresponding variable based on service name(This is required because we need to take out every version from this shell script step and use in as input to helm service runtime input)
   case $pattern in 
      "infra-configuration-service")
         latest_infra_configuration_service="$version"
         ;;
      "core-annuities-service")
         latest_core_annuities_service="$version"
         ;;
	  "core-business-service")
         latest_core_business_service="$version"
         ;;
      "core-defined-benefit-service")
         latest_core_defined_benefit_service="$version"
         ;;	
      "core-gateway-service")
         latest_core_gateway_service="$version"
         ;;
      "core-general-processing-service")
         latest_core_general_processing_service="$version"
         ;;
	  "core-investments-service")
         latest_core_investments_service="$version"
         ;;
      "core-loan-service")
         latest_core_loan_service="$version"
         ;;		
      "core-money-in-service")
         latest_core_money_in_service="$version"
         ;;
      "core-money-out-service")
         latest_core_money_out_service="$version"
         ;;
      "core-packet-service")
         latest_core_packet_service="$version"
         ;;
      "core-participant-service")
         latest_core_participant_service="$version"
         ;;
	  "core-plans-service")
         latest_core_plans_service="$version"
         ;;
      "core-security-service")
         latest_core_security_service="$version"
         ;;	
      "core-textfile-service")
         latest_core_textfile_service="$version"
         ;;
      "core-trade-service")
         latest_core_trade_service="$version"
         ;;
	  "core-transaction-service")
         latest_core_transaction_service="$version"
         ;;
      "infra-cache-service")
         latest_infra_cache_service="$version"
         ;; 
      "core-utilities-service")
         latest_core_utilities_service="$version"
         ;;		 
   esac
done

#print the latest versions of all the services
echo "latest_infra_configuration_service version: $latest_infra_configuration_service"
echo "latest_core_annuities_service version: $latest_core_annuities_service"
echo "latest_core_business_service version: $latest_core_business_service"
echo "latest_core_defined_benefit_service version: $latest_core_defined_benefit_service"
echo "latest_core_gateway_service version: $latest_core_gateway_service"
echo "latest_core_general_processing_service version: $latest_core_general_processing_service"
echo "latest_core_investments_service version: $latest_core_investments_service"
echo "latest_core_loan_service version: $latest_core_loan_service"
echo "latest_core_money_in_service version: $latest_core_money_in_service"
echo "latest_core_money_out_service version: $latest_core_money_out_service"
echo "latest_core_packet_service version: $latest_core_packet_service"
echo "latest_core_participant_service version: $latest_core_participant_service"
echo "latest_core_plans_service version: $latest_core_plans_service"
echo "latest_core_security_service version: $latest_core_security_service"
echo "latest_core_textfile_service version: $latest_core_textfile_service"
echo "latest_core_trade_service version: $latest_core_trade_service"
echo "latest_core_transaction_service version: $latest_core_transaction_service"
echo "latest_infra_cache_service version: $latest_infra_cache_service"
echo "latest_core_utilities_service version: $latest_core_utilities_service"
