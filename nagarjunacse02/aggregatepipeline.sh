#!/bin/bash
pipeline_name="<+stage.variables.pipeline_name>"
artifactory_version_number="<+stage.variables.artifactory_version_number>"
execute_type="<+stage.variables.execute_type>"
Websphere_operation="<+stage.variables.Websphere_operation>"
script_name="<+stage.variables.script_name>"
JOB_NAME="<+stage.variables.JOB_NAME>"

check_vars() {
  local list_of_vars=("Websphere_operation" "execute_type")
  local do_exit="false"
  for var in "${list_of_vars[@]}"; do
    if [[ ${!var} =~ .*"Choose".* ]]; then
      echo "Error: Incorrect choice for the variable $var"
      do_exit="true"
    fi
  done
  if [[ "$do_exit" == "true" ]]; then
    exit 100
  fi
}

check_vars

if [[ $pipeline_name =~ 'IBS_UserPref-System-deploy-userpref' ]]; then
  curl -X POST -H 'content-type: application/json' --url 'https://app.harness.io/gateway/pipeline/api/webhook/custom/v2?accountIdentifier=XzgUIuZXRMWymCzLKYZpCg&orgIdentifier=IBS_Integrated_Core_System&projectIdentifier=IBSUserPreferencesLowerRegion&pipelineIdentifier=IBS_UserPrefSystemdeployuserpref&triggerIdentifier=IBS_UserPrefSystemdeployuserpref' -d "{\"artifactory_version_number\": \"$artifactory_version_number\", \"execute_type\" : \"$execute_type\", \"Websphere_operation\" : \"$Websphere_operation\", \"script_name\" : \"$script_name\", \"JOB_NAME\" : \"$JOB_NAME\"}"
else
  echo "pipeline variable is not set properly"
fi
