Warning: A secret was passed to "sh" using Groovy String interpolation, which is insecure.

		 Affected argument(s) used the following variable(s): [PASSWORD, USERNAME]

		 See https://jenkins.io/redirect/groovy-string-interpolation for details.

+ /usr/bin/perl deploy_migrate_001_bnk.pl **** ****

----------------------------------------------------------------------------

---

--- JOB INPUTS

---

----------------------------------------------------------------------------



job_name                   is:IBSDO-System/IBSDO-System-Websphere-GAUnit_Desktop

artifactory_version_number is:InteropTest2024.1-SNAPSHOT

ticket_number              is:

execute_type               is:execute

ws_operation               is:deploy

jb_operation               is:

app_group                  is:IBSDO

env                        is:System

deploy_type                is:Websphere

app_name                   is:GAUnit_Desktop

ini_name                   is:IBSDO-System-Websphere-GAUnit_Desktop

----------------------------------------------------------------------------

---

--- Extract application control files from Artifactory

---

----------------------------------------------------------------------------



--- cmd is:curl --user ****:**** -s -k -f -o /home/jenkins/workspace/IBSDO-System/IBSDO-System-Websphere-GAUnit_Desktop/jenkins_application_control_files/IBSDO.zip https://artifactory.fis.dev/artifactory/harvest-maven-snapshot-local/Jenkins_application_control_files/IBSDO/0.1.0-SNAPSHOT/IBSDO-0.1.0-SNAPSHOT.zip

----------------------------------------------------------------------------

---

--- Unzip application control files

---

----------------------------------------------------------------------------



--- cmd is:unzip -q /home/jenkins/workspace/IBSDO-System/IBSDO-System-Websphere-GAUnit_Desktop/jenkins_application_control_files/IBSDO.zip -d /home/jenkins/workspace/IBSDO-System/IBSDO-System-Websphere-GAUnit_Desktop/jenkins_application_control_files

----------------------------------------------------------------------------

---

--- Execute Websphere deploy

---

----------------------------------------------------------------------------



----------------------------------------------------------------------------

---

--- extract HV_xPRES from Artifactory

---

----------------------------------------------------------------------------



--- cmd is:curl --user ****:**** -s -k -f -o /home/jenkins/workspace/IBSDO-System/IBSDO-System-Websphere-GAUnit_Desktop/HV_xPRES/HV_xPRES.zip https://artifactory.fis.dev/artifactory/harvest-maven-snapshot-local/Jenkins_HV_xPRES/HV_xPRES/0.1.0-SNAPSHOT/HV_xPRES-0.1.0-SNAPSHOT.zip

----------------------------------------------------------------------------

---

--- Execute websphere deploy

---

----------------------------------------------------------------------------



----------------------------------------------------------------------------

---

--- Create deploy command file :/home/jenkins/workspace/IBSDO-System/IBSDO-System-Websphere-GAUnit_Desktop/application_data/JenkinsDeploy.ksh

---

----------------------------------------------------------------------------



----------------------------------------------------------------------------

---

--- Read deployment ini file:/home/jenkins/workspace/IBSDO-System/IBSDO-System-Websphere-GAUnit_Desktop/jenkins_application_control_files/src/IBSDO-System-deploy-GAUnit_Desktop.ini

---

----------------------------------------------------------------------------



artifactory_path       is: https://artifactory.fis.dev/artifactory/ibsdo-maven-snapshot-local/com/fis/IBS/do

artifactory_filename   is: opstopdo

artifactory_filetype   is: ear

artifactory_classifier is: 

dmserver               is: VLCAPDCCIBSDM1.fisdev.local

update_vHost           is: yes

vHost                  is: MD_Desktop_DO_Unit_host

warName                is: opstopdo

Mon Jul 15 13:34:09 CDT 2024

----------------------------------------------------------------------------

---

--- wasadmin user can ssh to dmserver:VLCAPDCCIBSDM1.fisdev.local

---

----------------------------------------------------------------------------



----------------------------------------------------------------------------

---

--- Extract application deploy data file from Artifactory

---

----------------------------------------------------------------------------



--- cmd is:curl --user ****:**** -s -k -f -o /home/jenkins/workspace/IBSDO-System/IBSDO-System-Websphere-GAUnit_Desktop/application_data/opstopdo.ear https://artifactory.fis.dev/artifactory/ibsdo-maven-snapshot-local/com/fis/IBS/do/opstopdo/InteropTest2024.1-SNAPSHOT/opstopdo-InteropTest2024.1-SNAPSHOT.ear

----------------------------------------------------------------------------

---

--- Configure opstopdo.ear for specific environment

---

----------------------------------------------------------------------------



--- create cmd is:mkdir /home/jenkins/workspace/IBSDO-System/IBSDO-System-Websphere-GAUnit_Desktop/application_data/ear_tmp

--- copy cmd is:cp /home/jenkins/workspace/IBSDO-System/IBSDO-System-Websphere-GAUnit_Desktop/application_data/opstopdo.ear /home/jenkins/workspace/IBSDO-System/IBSDO-System-Websphere-GAUnit_Desktop/application_data/ear_tmp/opstopdo.ear

--- cd to /home/jenkins/workspace/IBSDO-System/IBSDO-System-Websphere-GAUnit_Desktop/application_data/ear_tmp

--- uncompress cmd is:jar xf opstopdo.ear

--- remove cmd is:rm -f /home/jenkins/workspace/IBSDO-System/IBSDO-System-Websphere-GAUnit_Desktop/application_data/ear_tmp/opstopdo.ear

----------------------------------------------------------------------------

---

--- processing war file:opstopdo.war

---

----------------------------------------------------------------------------



--- create cmd is:mkdir /home/jenkins/workspace/IBSDO-System/IBSDO-System-Websphere-GAUnit_Desktop/application_data/ear_tmp/opstopdo

--- copy cmd is:cp /home/jenkins/workspace/IBSDO-System/IBSDO-System-Websphere-GAUnit_Desktop/application_data/ear_tmp/opstopdo.war /home/jenkins/workspace/IBSDO-System/IBSDO-System-Websphere-GAUnit_Desktop/application_data/ear_tmp/opstopdo/opstopdo.war   

--- cd to /home/jenkins/workspace/IBSDO-System/IBSDO-System-Websphere-GAUnit_Desktop/application_data/ear_tmp/opstopdo

--- uncompress cmd is:jar xf opstopdo.war

--- update vHost in directory WEB-INF 

--- remove cmd is:rm -f WEB-INF/ibm-web-bnd.xmi

--- move cmd is:mv WEB-INF/tmp-ibm-web-bnd.xmi WEB-INF/ibm-web-bnd.xmi

--- remove cmd is:rm -f /home/jenkins/workspace/IBSDO-System/IBSDO-System-Websphere-GAUnit_Desktop/application_data/ear_tmp/opstopdo/opstopdo.war

--- jar cmd is:jar cfM opstopdo.war -C /home/jenkins/workspace/IBSDO-System/IBSDO-System-Websphere-GAUnit_Desktop/application_data/ear_tmp/opstopdo *

--- remove cmd is:rm -f /home/jenkins/workspace/IBSDO-System/IBSDO-System-Websphere-GAUnit_Desktop/application_data/ear_tmp/opstopdo.war

--- copy cmd is:cp opstopdo.war /home/jenkins/workspace/IBSDO-System/IBSDO-System-Websphere-GAUnit_Desktop/application_data/ear_tmp/opstopdo.war

--- cd to /home/jenkins/workspace/IBSDO-System/IBSDO-System-Websphere-GAUnit_Desktop/application_data/ear_tmp

--- cmd is:rm -rf /home/jenkins/workspace/IBSDO-System/IBSDO-System-Websphere-GAUnit_Desktop/application_data/ear_tmp/opstopdo

--- jar cmd is:jar cfM opstopdo.ear -C /home/jenkins/workspace/IBSDO-System/IBSDO-System-Websphere-GAUnit_Desktop/application_data/ear_tmp *

--- copy cmd is:cp -f /home/jenkins/workspace/IBSDO-System/IBSDO-System-Websphere-GAUnit_Desktop/application_data/ear_tmp/opstopdo.ear /home/jenkins/workspace/IBSDO-System/IBSDO-System-Websphere-GAUnit_Desktop/application_data/opstopdo.ear

----------------------------------------------------------------------------

---

--- Prepare jenkins pipeline directory on target machine:VLCAPDCCIBSDM1.fisdev.local

---

----------------------------------------------------------------------------



--- cmd is:ssh -q -o StrictHostKeyChecking=no jenkins@VLCAPDCCIBSDM1.fisdev.local rm -rf /jenkins/IBSDO-System-deploy-GAUnit_Desktop

--- ssh cmd is:ssh -q -o StrictHostKeyChecking=no jenkins@VLCAPDCCIBSDM1.fisdev.local mkdir /jenkins/IBSDO-System-deploy-GAUnit_Desktop

----------------------------------------------------------------------------

---

--- Copy command file to target machine:VLCAPDCCIBSDM1.fisdev.local

---

----------------------------------------------------------------------------



--- scp cmd is:scp -q -o StrictHostKeyChecking=no /home/jenkins/workspace/IBSDO-System/IBSDO-System-Websphere-GAUnit_Desktop/application_data/JenkinsDeploy.ksh jenkins@VLCAPDCCIBSDM1.fisdev.local:/jenkins/IBSDO-System-deploy-GAUnit_Desktop

----------------------------------------------------------------------------

---

--- Copy application data to target machine:VLCAPDCCIBSDM1.fisdev.local

---

----------------------------------------------------------------------------



--- scp cmd is:scp -q -o StrictHostKeyChecking=no /home/jenkins/workspace/IBSDO-System/IBSDO-System-Websphere-GAUnit_Desktop/application_data/opstopdo.ear jenkins@VLCAPDCCIBSDM1.fisdev.local:/jenkins/IBSDO-System-deploy-GAUnit_Desktop

----------------------------------------------------------------------------

---

--- Copy HV_xPRES to target machine:VLCAPDCCIBSDM1.fisdev.local

---

----------------------------------------------------------------------------



--- ssh cmd is:ssh -q -o StrictHostKeyChecking=no jenkins@VLCAPDCCIBSDM1.fisdev.local mkdir /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES

--- scp cmd is:scp -q -o StrictHostKeyChecking=no /home/jenkins/workspace/IBSDO-System/IBSDO-System-Websphere-GAUnit_Desktop/HV_xPRES/HV_xPRES.zip jenkins@VLCAPDCCIBSDM1.fisdev.local:/jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES

----------------------------------------------------------------------------

---

--- Unzip HV_xPRES to target machine:VLCAPDCCIBSDM1.fisdev.local

---

----------------------------------------------------------------------------



--- ssh cmd is:ssh -q -o StrictHostKeyChecking=no jenkins@VLCAPDCCIBSDM1.fisdev.local unzip -q /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/HV_xPRES.zip -d /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES

----------------------------------------------------------------------------

---

--- Create HV_xPRES logs directory

---

----------------------------------------------------------------------------



--- ssh cmd is:ssh -q -o StrictHostKeyChecking=no jenkins@VLCAPDCCIBSDM1.fisdev.local mkdir /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs

----------------------------------------------------------------------------

---

--- Create symlinks directory

---

----------------------------------------------------------------------------



--- ssh cmd is:ssh -q -o StrictHostKeyChecking=no jenkins@VLCAPDCCIBSDM1.fisdev.local mkdir /jenkins/IBSDO-System-deploy-GAUnit_Desktop/symlinks

----------------------------------------------------------------------------

---

--- Create DEPLOY link

---

----------------------------------------------------------------------------



--- ssh cmd is:ssh -q -o StrictHostKeyChecking=no jenkins@VLCAPDCCIBSDM1.fisdev.local ln -s /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/bin/HarSuexecControlModule_linux /jenkins/IBSDO-System-deploy-GAUnit_Desktop/symlinks/DEPLOY

----------------------------------------------------------------------------

---

--- Set permissions of HV_xPRES directory

---

----------------------------------------------------------------------------



--- ssh cmd is:ssh -q -o StrictHostKeyChecking=no VLCAPDCCIBSDM1.fisdev.local chmod -R 755 /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES

----------------------------------------------------------------------------

---

--- Set permissions on /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs

---

----------------------------------------------------------------------------



--- ssh cmd is:ssh -q -o StrictHostKeyChecking=no jenkins@VLCAPDCCIBSDM1.fisdev.local chmod 777 /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs

----------------------------------------------------------------------------

---

--- Contents of command file /jenkins/IBSDO-System-deploy-GAUnit_Desktop/JenkinsDeploy.ksh

---

----------------------------------------------------------------------------



--- ssh cmd is:ssh -q -o StrictHostKeyChecking=no jenkins@VLCAPDCCIBSDM1.fisdev.local cat /jenkins/IBSDO-System-deploy-GAUnit_Desktop/JenkinsDeploy.ksh

#!/bin/ksh

XPHOME=/jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src; export XPHOME

/usr/bin/perl /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/scripts/WASDeploy.pl -group IBSDO -env IBSDO -state Development -owner wasadmin -perlPath /usr/bin/perl -debug 1 -cluster MD_Desktop_DO_Unit -appServerList MD_Desktop_DO_Unit _VLCAPDCCIBSAPP3:VLCAPDCCIBSAPP3_base1_node2 -wsDMProfileBase /opt/WebSphere/9/DeploymentManagers -wsDMProfile DeploymentManager_Unit -vHost MD_Desktop_DO_Unit_host -wsDeployedEarPath /opt/WebSphere/9/AppServerBase1/profiles/AppServerBase2/installedApps/Unit_Cell/opstopdo.ear -appName opstopdo -wsDeployOwner wasadmin -cellName Unit_Cell -wsASBProfileBase /opt/WebSphere/9/AppServerBase1/profiles -warName opstopdo -appServerBase AppServerBase2 -deployedEarPerms 775:774:Yes:Dev, Unit_Test, System_Test, UAT, Readiness ::: 775:774:No:Client_Test, Production, eProduction -delayStartList 10:2, 40:5, 50:7, 60:10, 100:20 -delayPostJVMStart 2 -delayMapWebModuleToServers 0 -boksPath /usr/boksm/bin -webModule opstopdo -cClassLoaderMode appwarLevel -cWarClassLoadPol false -startStopByCluster 1 -symlinkList /opt/WebSphere/9/AppServerBase1/profiles/AppServerBase2/installedApps/Unit_Cell/opstopdo.ear/opstopdo.war, /md_authoring/ga/do/AuthoredRules, AuthoredRules ::: /opt/WebSphere/9/AppServerBase1/profiles/AppServerBase2/installedApps/Unit_Cell/opstopdo.ear/opstopdo.war/WEB-INF/lib, /application/DO_Desktop/EnvJars, GAUnit -server VLCAPDCCIBSDM1.fisdev.local -ermPath /jenkins/IBSDO-System-deploy-GAUnit_Desktop -baseLogName IBSDO-System-deploy-GAUnit_Desktop -logPath /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs -logFile /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/IBSDO-System-deploy-GAUnit_Desktop-DP.log -symlinkPath /jenkins/IBSDO-System-deploy-GAUnit_Desktop/symlinks -wsDMJCLFile /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/was/jacl/wasDeployLib.jacl -earFile /jenkins/IBSDO-System-deploy-GAUnit_Desktop/opstopdo.ear 

----------------------------------------------------------------------------

---

--- launch deploy command on target machine:VLCAPDCCIBSDM1.fisdev.local

---

----------------------------------------------------------------------------



--- ssh cmd is:ssh -q -o StrictHostKeyChecking=no wasadmin@VLCAPDCCIBSDM1.fisdev.local /jenkins/IBSDO-System-deploy-GAUnit_Desktop/JenkinsDeploy.ksh &

----------------------------------------------------------------------------

---

--- Monitor status of WASDeploy on target machine:VLCAPDCCIBSDM1.fisdev.local

---

----------------------------------------------------------------------------



cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/error.log: No such file or directory

linux: 

WASDeploy suexecCommandLine is:/usr/bin/perl /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/scripts/WASDeploy.pl -group IBSDO -env IBSDO -state Development -debug 1 -server VLCAPDCCIBSDM1.fisdev.local -owner wasadmin -wsDeployOwner wasadmin -appName opstopdo -oldAppName opstopdo -wsDMProfile DeploymentManager_Unit -appServerList MD_Desktop_DO_Unit _VLCAPDCCIBSAPP3:VLCAPDCCIBSAPP3_base1_node2 -nodeList VLCAPDCCIBSAPP3_base1_node2 -wsDMJCLFile /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/was/jacl/wasDeployLib.jacl -cluster MD_Desktop_DO_Unit -deployType full -ermPath /jenkins/IBSDO-System-deploy-GAUnit_Desktop -logPath /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs -symlinkPath /jenkins/IBSDO-System-deploy-GAUnit_Desktop/symlinks -symlinkList /opt/WebSphere/9/AppServerBase1/profiles/AppServerBase2/installedApps/Unit_Cell/opstopdo.ear/opstopdo.war, /md_authoring/ga/do/AuthoredRules, AuthoredRules ::: /opt/WebSphere/9/AppServerBase1/profiles/AppServerBase2/installedApps/Unit_Cell/opstopdo.ear/opstopdo.war/WEB-INF/lib, /application/DO_Desktop/EnvJars, GAUnit -symlinkListPath  -logFile /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/IBSDO-System-deploy-GAUnit_Desktop-DP.log -earFile /jenkins/IBSDO-System-deploy-GAUnit_Desktop/opstopdo.ear -preDeployPath  -postDeployPath  -WASDir  -wsDeployedEarPath /opt/WebSphere/9/AppServerBase1/profiles/AppServerBase2/installedApps/Unit_Cell/opstopdo.ear -wasJCLPath /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/was/jacl/ -wsDMProfileBase /opt/WebSphere/9/DeploymentManagers -cacheList  -cWarClassLoadPol 0 -cClassLoaderMode appwarLevel -startStopByCluster 1 -perm  -deploy 1 -delayStartList 10:2, 40:5, 50:7, 60:10, 100:20 -delayPostJVMStart 2 -delayMapWebModuleToServers 0 -deploy 1 -cache 1 -modifiedJCL  -baseLogName IBSDO-System-deploy-GAUnit_Desktop -deployedEarPerms 775:774:Yes:Dev, Unit_Test, System_Test, UAT, Readiness ::: 775:774:No:Client_Test, Production, eProduction -preDeploy 1 -postDeploy 1 -boksPath /usr/boksm/bin -useMounts  -perlPath /usr/bin/perl -sshAccess  -additionalWebModules  -cellName Unit_Cell  -appServerBase AppServerBase2 -vHost MD_Desktop_DO_Unit_host     -uri opstopdo.war,WEB-INF/web.xml -warName opstopdo -webModule opstopdo  -wsASBProfileBase /opt/WebSphere/9/AppServerBase1/profiles -scrubSymlinks 0 -suexec 1 -XPHOME /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src -rcFile /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/IBSDO_Development-rcvalue.log

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/success.log: No such file or directory

--- WASDeploy still running on target machine:VLCAPDCCIBSDM1.fisdev.local

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/error.log: No such file or directory

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/success.log: No such file or directory

--- WASDeploy still running on target machine:VLCAPDCCIBSDM1.fisdev.local

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/error.log: No such file or directory

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/success.log: No such file or directory

--- WASDeploy still running on target machine:VLCAPDCCIBSDM1.fisdev.local

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/error.log: No such file or directory

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/success.log: No such file or directory

--- WASDeploy still running on target machine:VLCAPDCCIBSDM1.fisdev.local

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/error.log: No such file or directory

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/success.log: No such file or directory

--- WASDeploy still running on target machine:VLCAPDCCIBSDM1.fisdev.local

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/error.log: No such file or directory

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/success.log: No such file or directory

--- WASDeploy still running on target machine:VLCAPDCCIBSDM1.fisdev.local

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/error.log: No such file or directory

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/success.log: No such file or directory

--- WASDeploy still running on target machine:VLCAPDCCIBSDM1.fisdev.local

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/error.log: No such file or directory

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/success.log: No such file or directory

--- WASDeploy still running on target machine:VLCAPDCCIBSDM1.fisdev.local

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/error.log: No such file or directory

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/success.log: No such file or directory

--- WASDeploy still running on target machine:VLCAPDCCIBSDM1.fisdev.local

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/error.log: No such file or directory

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/success.log: No such file or directory

--- WASDeploy still running on target machine:VLCAPDCCIBSDM1.fisdev.local

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/error.log: No such file or directory

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/success.log: No such file or directory

--- WASDeploy still running on target machine:VLCAPDCCIBSDM1.fisdev.local

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/error.log: No such file or directory

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/success.log: No such file or directory

--- WASDeploy still running on target machine:VLCAPDCCIBSDM1.fisdev.local

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/error.log: No such file or directory

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/success.log: No such file or directory

--- WASDeploy still running on target machine:VLCAPDCCIBSDM1.fisdev.local

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/error.log: No such file or directory

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/success.log: No such file or directory

--- WASDeploy still running on target machine:VLCAPDCCIBSDM1.fisdev.local

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/error.log: No such file or directory

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/success.log: No such file or directory

--- WASDeploy still running on target machine:VLCAPDCCIBSDM1.fisdev.local

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/error.log: No such file or directory

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/success.log: No such file or directory

--- WASDeploy still running on target machine:VLCAPDCCIBSDM1.fisdev.local

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/error.log: No such file or directory

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/success.log: No such file or directory

--- WASDeploy still running on target machine:VLCAPDCCIBSDM1.fisdev.local

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/error.log: No such file or directory

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/success.log: No such file or directory

--- WASDeploy still running on target machine:VLCAPDCCIBSDM1.fisdev.local

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/error.log: No such file or directory

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/success.log: No such file or directory

--- WASDeploy still running on target machine:VLCAPDCCIBSDM1.fisdev.local

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/error.log: No such file or directory

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/success.log: No such file or directory

--- WASDeploy still running on target machine:VLCAPDCCIBSDM1.fisdev.local

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/error.log: No such file or directory

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/success.log: No such file or directory

--- WASDeploy still running on target machine:VLCAPDCCIBSDM1.fisdev.local

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/error.log: No such file or directory

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/success.log: No such file or directory

--- WASDeploy still running on target machine:VLCAPDCCIBSDM1.fisdev.local

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/error.log: No such file or directory

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/success.log: No such file or directory

--- WASDeploy still running on target machine:VLCAPDCCIBSDM1.fisdev.local

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/error.log: No such file or directory

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/success.log: No such file or directory

--- WASDeploy still running on target machine:VLCAPDCCIBSDM1.fisdev.local

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/error.log: No such file or directory

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/success.log: No such file or directory

--- WASDeploy still running on target machine:VLCAPDCCIBSDM1.fisdev.local

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/error.log: No such file or directory

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/success.log: No such file or directory

deployReturnCode is:

--- WASDeploy still running on target machine:VLCAPDCCIBSDM1.fisdev.local

cat: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/error.log: No such file or directory

----------------------------------------------------------------------------

---

--- WASDeploy completed successfully - please review log

---

----------------------------------------------------------------------------



      ** In /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/scripts/WASDeploy.pl Module ...

         ** Parameters passed into module:

         -> -group IBSDO -env IBSDO -state Development -owner wasadmin -perlPath /usr/bin/perl -debug 1 -cluster MD_Desktop_DO_Unit -appServerList MD_Desktop_DO_Unit _VLCAPDCCIBSAPP3:VLCAPDCCIBSAPP3_base1_node2 -wsDMProfileBase /opt/WebSphere/9/DeploymentManagers -wsDMProfile DeploymentManager_Unit -vHost MD_Desktop_DO_Unit_host -wsDeployedEarPath /opt/WebSphere/9/AppServerBase1/profiles/AppServerBase2/installedApps/Unit_Cell/opstopdo.ear -appName opstopdo -wsDeployOwner wasadmin -cellName Unit_Cell -wsASBProfileBase /opt/WebSphere/9/AppServerBase1/profiles -warName opstopdo -appServerBase AppServerBase2 -deployedEarPerms 775:774:Yes:Dev, Unit_Test, System_Test, UAT, Readiness ::: 775:774:No:Client_Test, Production, eProduction -delayStartList 10:2, 40:5, 50:7, 60:10, 100:20 -delayPostJVMStart 2 -delayMapWebModuleToServers 0 -boksPath /usr/boksm/bin -webModule opstopdo -cClassLoaderMode appwarLevel -cWarClassLoadPol false -startStopByCluster 1 -symlinkList /opt/WebSphere/9/AppServerBase1/profiles/AppServerBase2/installedApps/Unit_Cell/opstopdo.ear/opstopdo.war, /md_authoring/ga/do/AuthoredRules, AuthoredRules ::: /opt/WebSphere/9/AppServerBase1/profiles/AppServerBase2/installedApps/Unit_Cell/opstopdo.ear/opstopdo.war/WEB-INF/lib, /application/DO_Desktop/EnvJars, GAUnit -server VLCAPDCCIBSDM1.fisdev.local -ermPath /jenkins/IBSDO-System-deploy-GAUnit_Desktop -baseLogName IBSDO-System-deploy-GAUnit_Desktop -logPath /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs -logFile /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/IBSDO-System-deploy-GAUnit_Desktop-DP.log -symlinkPath /jenkins/IBSDO-System-deploy-GAUnit_Desktop/symlinks -wsDMJCLFile /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/was/jacl/wasDeployLib.jacl -earFile /jenkins/IBSDO-System-deploy-GAUnit_Desktop/opstopdo.ear

      ** Verifying symbolic link

         -> base dir: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/symlinks

         -> symlink:  DEPLOY -> /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/bin/HarSuexecControlModule_linux

         !> Symbolic link verified

      ** Setting permissions on log files

      ** Loading WebSphere Message Table.

      ** Printing out all parameterss.

         -> Parameters for deploy script:

            => group               = IBSDO

            => env                 = IBSDO

            => state               = Development

            => owner               = wasadmin

            => DM server           = VLCAPDCCIBSDM1.fisdev.local

            => symlinkName         = 

            => wsDeployOwner       = wasadmin

            => deployType          = full

            => debug               = 1

            => delayStartTime      = 10

            => delayPostJVMStart   = 120

            => delayMapWebModuleToServers = 

            => ear size            = 105.4 Mb

         -> Parms for WebSphere deploy process:

            => appName             = opstopdo

            => oldAppName          = opstopdo

            => appServerList       = MD_Desktop_DO_Unit _VLCAPDCCIBSAPP3:VLCAPDCCIBSAPP3_base1_node2

            => wsDMJCLFile         = /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/was/jacl/wasDeployLib.jacl

            => cluster             = MD_Desktop_DO_Unit

            => webModule           = opstopdo

            => webSeverList        = 

            => uri                 = opstopdo.war,WEB-INF/web.xml

            => warName             = opstopdo

            => modifiedJCL         = 

            => cClassLoaderMode    = appwarLevel

            => vHost               = MD_Desktop_DO_Unit_host

            => appServerBase       = AppServerBase2

         -> Parameters for remote access to nodes:

            => nodeList            = VLCAPDCCIBSAPP3_base1_node2

            => symlinkList         = /opt/WebSphere/9/AppServerBase1/profiles/AppServerBase2/installedApps/Unit_Cell/opstopdo.ear/opstopdo.war, /md_authoring/ga/do/AuthoredRules, AuthoredRules ::: /opt/WebSphere/9/AppServerBase1/profiles/AppServerBase2/installedApps/Unit_Cell/opstopdo.ear/opstopdo.war/WEB-INF/lib, /application/DO_Desktop/EnvJars, GAUnit

            => symlinkListPath     = 

            => wsDMProfile         = DeploymentManager_Unit

            => wsDeployedEarPath   = /opt/WebSphere/9/AppServerBase1/profiles/AppServerBase2/installedApps/Unit_Cell/opstopdo.ear

         -> Deployed Ear Permissions:

            => dirPermissions      = 755

            => filePermissions     = 754

         -> Log Files:

            => logFile             = /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/IBSDO-System-deploy-GAUnit_Desktop-DP.log

            => deployLog           = /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/IBSDO-System-deploy-GAUnit_Desktop-Deploy0.log

            => deployWipLog        = /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/IBSDO-System-deploy-GAUnit_Desktop-DeployWip.log

         -> Paths to Files:

            => wsDMAdminPath       = /opt/WebSphere/9/DeploymentManagers/profiles/DeploymentManager_Unit/bin/wsadmin.sh

            => wsDMRegenPluginPath = /opt/WebSphere/9/DeploymentManagers/profiles/DeploymentManager_Unit/bin/GenPluginCfg.sh

            => preDeployPath       = 

            => postDeployPath      = 

            => earFile             = /jenkins/IBSDO-System-deploy-GAUnit_Desktop/opstopdo.ear

         -> Paths and Dirs:

            => ermPath             = /jenkins/IBSDO-System-deploy-GAUnit_Desktop

            => logPath             = /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs

            => perlPath            = /usr/bin/perl

            => symlinkPath         = /jenkins/IBSDO-System-deploy-GAUnit_Desktop/symlinks

            => binPath             = 

            => iniPath             = 

            => scriptPath          = 

            => wasScriptPath       = 

            => wsDMProfileBase     = /opt/WebSphere/9/DeploymentManagers

            => wsDMProfileHome     = /opt/WebSphere/9/DeploymentManagers/profiles/DeploymentManager_Unit

            => wsASBProfileHome  = /opt/WebSphere/9/AppServerBase1/profiles/AppServerBase2

            => wasScriptPath       = /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/was/scripts

            => wasJCLPath          = /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/was/jacl/

         -> Flags:

            => proc                = 1

            => deploy              = 1 1

            => cache               = 1

            => jsp                 = 0

            => preDeploy           = 1

            => postDeploy          = 1

            => propagate plug-ins  = 0

            => flagSuexecCall      = 1

            => setPermissions      = 1

            => cWarClassLoadPol    = 0

            => startStopByCluster  = 1

            => scrubSymlinks       = 0

      ** Performing deploy process: full.

         ** Checking for existence of application.

            *> Time in:  Monday, July 15, 2024 at 13:34:48

            => checkAppExistence: opstopdo

            => command line: /opt/WebSphere/9/DeploymentManagers/profiles/DeploymentManager_Unit/bin/wsadmin.sh -f /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/was/jacl/checkAppExistence.jacl "opstopdo"  /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/was/jacl/wasDeployLib.jacl

               -> returnStatus: Successful Successful: 0

            *> Time out: Monday, July 15, 2024 at 13:34:56

            !>  Successful: checkAppExistence.

                WASX7209I: Connected to process "dmgr" on node Unit_Cell_Manager using RMI connector;  The type of process is: DeploymentManager

                WASX7303I: The following options are passed to the scripting environment and are available as arguments that are stored in the argv variable: "[opstopdo, /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/was/jacl/wasDeployLib.jacl]"



         ** Stopping application by cluster.

            *> Time in:  Monday, July 15, 2024 at 13:34:56

            => command line: /opt/WebSphere/9/DeploymentManagers/profiles/DeploymentManager_Unit/bin/wsadmin.sh -f /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/was/jacl/stopClusterMain.jacl MD_Desktop_DO_Unit  /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/was/jacl/wasDeployLib.jacl

            *> Time out: Monday, July 15, 2024 at 13:36:03

            !>  Successful: stopClusterMain.

                WASX7209I: Connected to process "dmgr" on node Unit_Cell_Manager using RMI connector;  The type of process is: DeploymentManager

                WASX7303I: The following options are passed to the scripting environment and are available as arguments that are stored in the argv variable: "[MD_Desktop_DO_Unit, /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/was/jacl/wasDeployLib.jacl]"

                MD_Desktop_DO_Unit

                		In procedure stopping cluster 

                MD_Desktop_DO_Unit

                Checking for existence of cluster MD_Desktop_DO_Unit

                 Checking to see if the MD_Desktop_DO_Unit is stopped.

                websphere.cluster.running

                stopping cluster MD_Desktop_DO_Unit ....

                sucessfully sent stop signal to cluster MD_Desktop_DO_Unit.

                checking the status of cluster to make sure it is up

                cluster MD_Desktop_DO_Unit stopped successful. exiting...

                0



         ** Removing Symlinks

            *> Time in:  Monday, July 15, 2024 at 13:36:03

            => VLCAPDCCIBSAPP3: /usr/boksm/bin/ssh -o GlobalKnownHostsFile= wasadmin@VLCAPDCCIBSAPP3 "rm -rf /opt/WebSphere/9/AppServerBase1/profiles/AppServerBase2/installedApps/Unit_Cell/opstopdo.ear/opstopdo.war/AuthoredRules" >>/jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/IBSDO-System-deploy-GAUnit_Desktop-DeployWip.log 2>&1

            => VLCAPDCCIBSAPP3: /usr/boksm/bin/ssh -o GlobalKnownHostsFile= wasadmin@VLCAPDCCIBSAPP3 "rm -rf /opt/WebSphere/9/AppServerBase1/profiles/AppServerBase2/installedApps/Unit_Cell/opstopdo.ear/opstopdo.war/AuthoredRulesrm -rf /opt/WebSphere/9/AppServerBase1/profiles/AppServerBase2/installedApps/Unit_Cell/opstopdo.ear/opstopdo.war/WEB-INF/lib/GAUnit" >>/jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/IBSDO-System-deploy-GAUnit_Desktop-DeployWip.log 2>&1

            *> Time out: Monday, July 15, 2024 at 13:36:04

            !>  Successful: Removing Symlinks.

                *******************************************************************************

                **                     Fidelity Information Services                         **

                **             Proprietary - Use Pursuant To Company Policy                  **

                *******************************************************************************

                **                                                                           **

                **  SECURITY NOTICE:                                                         **

                **  This computer system contains sensitive client information managed by    **

                **  FIS and is intended for official and other authorized use only.          **

                **  Unauthorized access or use of this system may subject violators to       **

                **  administrative action, civil, and/or criminal prosecution under the      **

                **  United States Criminal Code (Title 18 U.S.C. \247 1030).                 **

                **  All information on this computer system may be monitored, intercepted,   **

                **  recorded, read, copied, or captured and disclosed by and to authorized   **

                **  personnel for official purposes, including criminal prosecution.         **

                **  You have no expectations of privacy using this system. Any authorized    **

                **  or unauthorized use of this computer system signifies consent to and     **

                **  compliance with FIS policies and those security/privacy compliance       **

                **  regulations required by external governing bodies and these terms.       **

                **                                                                           **

                **  By logging into this server, you agree to accept these terms.            **

                *******************************************************************************

                **                          BOKS MANAGED SYSTEM                              **

                *******************************************************************************

                *******************************************************************************

                **                     Fidelity Information Services                         **

                **             Proprietary - Use Pursuant To Company Policy                  **

                *******************************************************************************

                **                                                                           **

                **  SECURITY NOTICE:                                                         **

                **  This computer system contains sensitive client information managed by    **

                **  FIS and is intended for official and other authorized use only.          **

                **  Unauthorized access or use of this system may subject violators to       **

                **  administrative action, civil, and/or criminal prosecution under the      **

                **  United States Criminal Code (Title 18 U.S.C. \247 1030).                 **

                **  All information on this computer system may be monitored, intercepted,   **

                **  recorded, read, copied, or captured and disclosed by and to authorized   **

                **  personnel for official purposes, including criminal prosecution.         **

                **  You have no expectations of privacy using this system. Any authorized    **

                **  or unauthorized use of this computer system signifies consent to and     **

                **  compliance with FIS policies and those security/privacy compliance       **

                **  regulations required by external governing bodies and these terms.       **

                **                                                                           **

                **  By logging into this server, you agree to accept these terms.            **

                *******************************************************************************

                **                          BOKS MANAGED SYSTEM                              **

                *******************************************************************************



         ** Uninstalling application.

            *> Time in:  Monday, July 15, 2024 at 13:36:04

            => uninstallApp: opstopdo

            => command line: /opt/WebSphere/9/DeploymentManagers/profiles/DeploymentManager_Unit/bin/wsadmin.sh -f /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/was/jacl/uninstallApp.jacl "opstopdo"  /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/was/jacl/wasDeployLib.jacl

            *> Time out: Monday, July 15, 2024 at 13:36:14

            !>  Successful: uninstallApp.

                WASX7209I: Connected to process "dmgr" on node Unit_Cell_Manager using RMI connector;  The type of process is: DeploymentManager

                WASX7303I: The following options are passed to the scripting environment and are available as arguments that are stored in the argv variable: "[opstopdo, /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/was/jacl/wasDeployLib.jacl]"

                app is opstopdo

                ADMA5017I: Uninstallation of opstopdo started.

                ADMA5104I: The server index entry for WebSphere:cell=Unit_Cell,node=VLCAPDCCIBSAPP3_base1_node2 is updated successfully.

                ADMA5102I: The configuration data for opstopdo from the configuration repository is deleted successfully.

                ADMA5011I: The cleanup of the temp directory for application opstopdo is complete.

                ADMA5106I: Application opstopdo uninstalled successfully.



         ** Synchronizing application to all nodes.

            *> Time in:  Monday, July 15, 2024 at 13:36:14

            => syncNodes: VLCAPDCCIBSAPP3_base1_node2

            => command line: /opt/WebSphere/9/DeploymentManagers/profiles/DeploymentManager_Unit/bin/wsadmin.sh -f /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/was/jacl/syncNodes.jacl VLCAPDCCIBSAPP3_base1_node2  /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/was/jacl/wasDeployLib.jacl

            *> Time out: Monday, July 15, 2024 at 13:36:22

            !>  Successful: syncNodes.

                WASX7209I: Connected to process "dmgr" on node Unit_Cell_Manager using RMI connector;  The type of process is: DeploymentManager

                WASX7303I: The following options are passed to the scripting environment and are available as arguments that are stored in the argv variable: "[VLCAPDCCIBSAPP3_base1_node2, /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/was/jacl/wasDeployLib.jacl]"

                Done with synchronization.



         ** Installing application.

            *> Time in:  Monday, July 15, 2024 at 13:36:22

            => Installing App: opstopdo

            => earFile: /jenkins/IBSDO-System-deploy-GAUnit_Desktop/opstopdo.ear

            => cluster: MD_Desktop_DO_Unit

            => command line: /opt/WebSphere/9/DeploymentManagers/profiles/DeploymentManager_Unit/bin/wsadmin.sh -javaoption -Xms128m -javaoption -Xmx512m -f /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/was/jacl/installApp.jacl "opstopdo" /jenkins/IBSDO-System-deploy-GAUnit_Desktop/opstopdo.ear MD_Desktop_DO_Unit 0  /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/was/jacl/wasDeployLib.jacl

            *> Time out: Monday, July 15, 2024 at 13:36:54

            !>  Successful: installApp.

                WASX7209I: Connected to process "dmgr" on node Unit_Cell_Manager using RMI connector;  The type of process is: DeploymentManager

                WASX7303I: The following options are passed to the scripting environment and are available as arguments that are stored in the argv variable: "[opstopdo, /jenkins/IBSDO-System-deploy-GAUnit_Desktop/opstopdo.ear, MD_Desktop_DO_Unit, 0, /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/was/jacl/wasDeployLib.jacl]"

                app is opstopdo

                earfile is /jenkins/IBSDO-System-deploy-GAUnit_Desktop/opstopdo.ear

                cluster is MD_Desktop_DO_Unit

                preCompile is 0

                $AdminApp install /jenkins/IBSDO-System-deploy-GAUnit_Desktop/opstopdo.ear {-cluster MD_Desktop_DO_Unit}

                cmd is $AdminApp install /jenkins/IBSDO-System-deploy-GAUnit_Desktop/opstopdo.ear {-cluster MD_Desktop_DO_Unit -appname opstopdo } 

                ADMA5016I: Installation of opstopdo started.

                ADMA5058I: Application and module versions are validated with versions of deployment targets.

                ADMA5005I: The application opstopdo is configured in the WebSphere Application Server repository.

                ADMA5005I: The application opstopdo is configured in the WebSphere Application Server repository.

                ADMA5081I: The bootstrap address for client module is configured in the WebSphere Application Server repository.

                ADMA5053I: The library references for the installed optional package are created.

                ADMA5005I: The application opstopdo is configured in the WebSphere Application Server repository.

                ADMA5001I: The application binaries are saved in /opt/WebSphere/9/DeploymentManagers/profiles/DeploymentManager_Unit/wstemp/Script190b7ae89bf/workspace/cells/Unit_Cell/applications/opstopdo.ear/opstopdo.ear

                ADMA5005I: The application opstopdo is configured in the WebSphere Application Server repository.

                SECJ0400I: Successfully updated the application opstopdo with the appContextIDForSecurity information.

                ADMA5005I: The application opstopdo is configured in the WebSphere Application Server repository.

                ADMA5005I: The application opstopdo is configured in the WebSphere Application Server repository.

                ADMA5113I: Activation plan created successfully.

                ADMA5011I: The cleanup of the temp directory for application opstopdo is complete.

                ADMA5013I: Application opstopdo installed successfully.



         ** Modifying the ClassLoaderMode.

            *> Time in:  Monday, July 15, 2024 at 13:36:54

            => changeClassLoaderMode: opstopdo

            => Changing class loader mode to parent last at: 2

            => command line: /opt/WebSphere/9/DeploymentManagers/profiles/DeploymentManager_Unit/bin/wsadmin.sh -f /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/was/jacl/changeClassLoaderMode.jacl "opstopdo" 2  /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/was/jacl/wasDeployLib.jacl

               -> returnStatus: Successful Successful: 0

            *> Time out: Monday, July 15, 2024 at 13:37:03

            !>  Successful: changeClassLoaderMode.

                WASX7209I: Connected to process "dmgr" on node Unit_Cell_Manager using RMI connector;  The type of process is: DeploymentManager

                WASX7303I: The following options are passed to the scripting environment and are available as arguments that are stored in the argv variable: "[opstopdo, 2, /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/was/jacl/wasDeployLib.jacl]"

                appName is opstopdo  



         ** Synchronizing application to all nodes.

            *> Time in:  Monday, July 15, 2024 at 13:37:03

            => syncNodes: VLCAPDCCIBSAPP3_base1_node2

            => command line: /opt/WebSphere/9/DeploymentManagers/profiles/DeploymentManager_Unit/bin/wsadmin.sh -f /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/was/jacl/syncNodes.jacl VLCAPDCCIBSAPP3_base1_node2  /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/was/jacl/wasDeployLib.jacl

            *> Time out: Monday, July 15, 2024 at 13:37:11

            !>  Successful: syncNodes.

                WASX7209I: Connected to process "dmgr" on node Unit_Cell_Manager using RMI connector;  The type of process is: DeploymentManager

                WASX7303I: The following options are passed to the scripting environment and are available as arguments that are stored in the argv variable: "[VLCAPDCCIBSAPP3_base1_node2, /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/was/jacl/wasDeployLib.jacl]"

                Done with synchronization.



         !> Due to the size of the ear, 105.4 Mb, all subsequent processes will be delayed including the start of the cluster, JVMs and Application:

            => 10 minutes

         ** Starting delay.

            *> Time in:  Monday, July 15, 2024 at 13:37:11

         ** Changing permissions on the deployed ear for each node

            -> 755: directory permissions

            -> 754: file permissions

            *> Time in:  Monday, July 15, 2024 at 13:47:11

            => VLCAPDCCIBSAPP3: /usr/boksm/bin/ssh -o GlobalKnownHostsFile= wasadmin@VLCAPDCCIBSAPP3 "find /opt/WebSphere/9/AppServerBase1/profiles/AppServerBase2/installedApps/Unit_Cell/opstopdo.ear -type d -exec chmod 755 {} \;" >>/jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/IBSDO-System-deploy-GAUnit_Desktop-DeployWip.log 2>&1

            => VLCAPDCCIBSAPP3: /usr/boksm/bin/ssh -o GlobalKnownHostsFile= wasadmin@VLCAPDCCIBSAPP3 "find /opt/WebSphere/9/AppServerBase1/profiles/AppServerBase2/installedApps/Unit_Cell/opstopdo.ear -type f -exec chmod 754 {} \;" >>/jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/IBSDO-System-deploy-GAUnit_Desktop-DeployWip.log 2>&1

            *> Time out: Monday, July 15, 2024 at 13:47:13

            !>  Successful: Setting permisssions on files and directories.

                *******************************************************************************

                **                     Fidelity Information Services                         **

                **             Proprietary - Use Pursuant To Company Policy                  **

                *******************************************************************************

                **                                                                           **

                **  SECURITY NOTICE:                                                         **

                **  This computer system contains sensitive client information managed by    **

                **  FIS and is intended for official and other authorized use only.          **

                **  Unauthorized access or use of this system may subject violators to       **

                **  administrative action, civil, and/or criminal prosecution under the      **

                **  United States Criminal Code (Title 18 U.S.C. \247 1030).                 **

                **  All information on this computer system may be monitored, intercepted,   **

                **  recorded, read, copied, or captured and disclosed by and to authorized   **

                **  personnel for official purposes, including criminal prosecution.         **

                **  You have no expectations of privacy using this system. Any authorized    **

                **  or unauthorized use of this computer system signifies consent to and     **

                **  compliance with FIS policies and those security/privacy compliance       **

                **  regulations required by external governing bodies and these terms.       **

                **                                                                           **

                **  By logging into this server, you agree to accept these terms.            **

                *******************************************************************************

                **                          BOKS MANAGED SYSTEM                              **

                *******************************************************************************

                *******************************************************************************

                **                     Fidelity Information Services                         **

                **             Proprietary - Use Pursuant To Company Policy                  **

                *******************************************************************************

                **                                                                           **

                **  SECURITY NOTICE:                                                         **

                **  This computer system contains sensitive client information managed by    **

                **  FIS and is intended for official and other authorized use only.          **

                **  Unauthorized access or use of this system may subject violators to       **

                **  administrative action, civil, and/or criminal prosecution under the      **

                **  United States Criminal Code (Title 18 U.S.C. \247 1030).                 **

                **  All information on this computer system may be monitored, intercepted,   **

                **  recorded, read, copied, or captured and disclosed by and to authorized   **

                **  personnel for official purposes, including criminal prosecution.         **

                **  You have no expectations of privacy using this system. Any authorized    **

                **  or unauthorized use of this computer system signifies consent to and     **

                **  compliance with FIS policies and those security/privacy compliance       **

                **  regulations required by external governing bodies and these terms.       **

                **                                                                           **

                **  By logging into this server, you agree to accept these terms.            **

                *******************************************************************************

                **                          BOKS MANAGED SYSTEM                              **

                *******************************************************************************



         ** Creating Symlinks

            *> Time in:  Monday, July 15, 2024 at 13:47:13

            => VLCAPDCCIBSAPP3: /usr/boksm/bin/ssh -o GlobalKnownHostsFile= wasadmin@VLCAPDCCIBSAPP3 "cd /opt/WebSphere/9/AppServerBase1/profiles/AppServerBase2/installedApps/Unit_Cell/opstopdo.ear/opstopdo.war;rm -rf AuthoredRules; ln -sn /md_authoring/ga/do/AuthoredRules AuthoredRules" >>/jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/IBSDO-System-deploy-GAUnit_Desktop-DeployWip.log 2>&1

            => VLCAPDCCIBSAPP3: /usr/boksm/bin/ssh -o GlobalKnownHostsFile= wasadmin@VLCAPDCCIBSAPP3 "cd /opt/WebSphere/9/AppServerBase1/profiles/AppServerBase2/installedApps/Unit_Cell/opstopdo.ear/opstopdo.war/WEB-INF/lib;rm -rf GAUnit; ln -sn /application/DO_Desktop/EnvJars GAUnit" >>/jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/IBSDO-System-deploy-GAUnit_Desktop-DeployWip.log 2>&1

            *> Time out: Monday, July 15, 2024 at 13:47:13

            !>  Successful: Creating Symlinks.

                *******************************************************************************

                **                     Fidelity Information Services                         **

                **             Proprietary - Use Pursuant To Company Policy                  **

                *******************************************************************************

                **                                                                           **

                **  SECURITY NOTICE:                                                         **

                **  This computer system contains sensitive client information managed by    **

                **  FIS and is intended for official and other authorized use only.          **

                **  Unauthorized access or use of this system may subject violators to       **

                **  administrative action, civil, and/or criminal prosecution under the      **

                **  United States Criminal Code (Title 18 U.S.C. \247 1030).                 **

                **  All information on this computer system may be monitored, intercepted,   **

                **  recorded, read, copied, or captured and disclosed by and to authorized   **

                **  personnel for official purposes, including criminal prosecution.         **

                **  You have no expectations of privacy using this system. Any authorized    **

                **  or unauthorized use of this computer system signifies consent to and     **

                **  compliance with FIS policies and those security/privacy compliance       **

                **  regulations required by external governing bodies and these terms.       **

                **                                                                           **

                **  By logging into this server, you agree to accept these terms.            **

                *******************************************************************************

                **                          BOKS MANAGED SYSTEM                              **

                *******************************************************************************

                *******************************************************************************

                **                     Fidelity Information Services                         **

                **             Proprietary - Use Pursuant To Company Policy                  **

                *******************************************************************************

                **                                                                           **

                **  SECURITY NOTICE:                                                         **

                **  This computer system contains sensitive client information managed by    **

                **  FIS and is intended for official and other authorized use only.          **

                **  Unauthorized access or use of this system may subject violators to       **

                **  administrative action, civil, and/or criminal prosecution under the      **

                **  United States Criminal Code (Title 18 U.S.C. \247 1030).                 **

                **  All information on this computer system may be monitored, intercepted,   **

                **  recorded, read, copied, or captured and disclosed by and to authorized   **

                **  personnel for official purposes, including criminal prosecution.         **

                **  You have no expectations of privacy using this system. Any authorized    **

                **  or unauthorized use of this computer system signifies consent to and     **

                **  compliance with FIS policies and those security/privacy compliance       **

                **  regulations required by external governing bodies and these terms.       **

                **                                                                           **

                **  By logging into this server, you agree to accept these terms.            **

                *******************************************************************************

                **                          BOKS MANAGED SYSTEM                              **

                *******************************************************************************



         ** Clearing Cache

            *> Time in:  Monday, July 15, 2024 at 13:47:13

            => VLCAPDCCIBSAPP3: /usr/boksm/bin/ssh -o GlobalKnownHostsFile= wasadmin@VLCAPDCCIBSAPP3 "rm -rf /opt/WebSphere/9/AppServerBase1/profiles/AppServerBase2/temp/VLCAPDCCIBSAPP3_base1_node2/MD_Desktop_DO_Unit _VLCAPDCCIBSAPP3" >>/jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/logs/IBSDO-System-deploy-GAUnit_Desktop-DeployWip.log 2>&1

            *> Time out: Monday, July 15, 2024 at 13:47:13

            !>  Successful: Clearing Cache.

                *******************************************************************************

                **                     Fidelity Information Services                         **

                **             Proprietary - Use Pursuant To Company Policy                  **

                *******************************************************************************

                **                                                                           **

                **  SECURITY NOTICE:                                                         **

                **  This computer system contains sensitive client information managed by    **

                **  FIS and is intended for official and other authorized use only.          **

                **  Unauthorized access or use of this system may subject violators to       **

                **  administrative action, civil, and/or criminal prosecution under the      **

                **  United States Criminal Code (Title 18 U.S.C. \247 1030).                 **

                **  All information on this computer system may be monitored, intercepted,   **

                **  recorded, read, copied, or captured and disclosed by and to authorized   **

                **  personnel for official purposes, including criminal prosecution.         **

                **  You have no expectations of privacy using this system. Any authorized    **

                **  or unauthorized use of this computer system signifies consent to and     **

                **  compliance with FIS policies and those security/privacy compliance       **

                **  regulations required by external governing bodies and these terms.       **

                **                                                                           **

                **  By logging into this server, you agree to accept these terms.            **

                *******************************************************************************

                **                          BOKS MANAGED SYSTEM                              **

                *******************************************************************************



         ** Starting application by cluster.

            *> Time in:  Monday, July 15, 2024 at 13:47:13

            => command line: /opt/WebSphere/9/DeploymentManagers/profiles/DeploymentManager_Unit/bin/wsadmin.sh -f /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/was/jacl/startClusterMain.jacl MD_Desktop_DO_Unit  /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/was/jacl/wasDeployLib.jacl

            *> Time out: Monday, July 15, 2024 at 13:48:21

            !>  Successful: startClusterMain.

                WASX7209I: Connected to process "dmgr" on node Unit_Cell_Manager using RMI connector;  The type of process is: DeploymentManager

                WASX7303I: The following options are passed to the scripting environment and are available as arguments that are stored in the argv variable: "[MD_Desktop_DO_Unit, /jenkins/IBSDO-System-deploy-GAUnit_Desktop/HV_xPRES/src/was/jacl/wasDeployLib.jacl]"

                MD_Desktop_DO_Unit

                		In procedure starting cluster 

                starting cluster MD_Desktop_DO_Unit.....

                Checking for existence of cluster MD_Desktop_DO_Unit

                 Checking to see if the MD_Desktop_DO_Unit is running.

                websphere.cluster.stopped

                starting cluster MD_Desktop_DO_Unit ....

                successfully sent a start signal to cluster MD_Desktop_DO_Unit.

                checking the status of cluster MD_Desktop_DO_Unit to make sure it is up.

                websphere.cluster.running

                cluster MD_Desktop_DO_Unit started successfully. exiting...

                0

                0



            -> Printing out missing message summary.

               => ADMA5081I . . .  The bootstrap address for client module is configured in the WebSphere Application Server repository.



               => ADMA5113I . . .  Activation plan created successfully.



         ** Exiting deploy process as wasadmin . . . . Successful
