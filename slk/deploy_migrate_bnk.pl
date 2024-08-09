1. Script downloads required files(like: jenkins_application_control_files, HV_xPRES) and unzip it
	cmd is:curl --user ****:**** -s -k -f -o /home/jenkins/workspace/IBSDO-Development/IBSDO-Development-Websphere-							DevUnit_Desktop/jenkins_application_control_files/IBSDO.zip https://artifactory.fis.dev/artifactory/harvest-maven-snapshot-				local/Jenkins_application_control_files/IBSDO/0.1.0-SNAPSHOT/IBSDO-0.1.0-SNAPSHOT.zip
	cmd is:unzip -q /home/jenkins/workspace/IBSDO-Development/IBSDO-Development-Websphere-DevUnit_Desktop/jenkins_application_control_files/IBSDO.zip -d 		/home/jenkins/workspace/IBSDO-Development/IBSDO-Development-Websphere-DevUnit_Desktop/jenkins_application_control_files

2. extract HV_xPRES from Artifactory
	cmd is:curl --user ****:**** -s -k -f -o /home/jenkins/workspace/IBSDO-Development/IBSDO-Development-Websphere-DevUnit_Desktop/HV_xPRES/HV_xPRES.zip 		https://artifactory.fis.dev/artifactory/harvest-maven-snapshot-local/Jenkins_HV_xPRES/HV_xPRES/0.1.0-SNAPSHOT/HV_xPRES-0.1.0-SNAPSHOT.zip

3. Create deploy command file :/home/jenkins/workspace/IBSDO-Development/IBSDO-Development-Websphere-DevSystem_Desktop/application_data/JenkinsDeploy.ksh

4. Read deployment ini file:/home/jenkins/workspace/IBSDO-Development/IBSDO-Development-Websphere-	DevSystem_Desktop/jenkins_application_control_files/src/IBSDO-Development-deploy-DevSystem_Desktop.ini
	
	artifactory_path       is: https://artifactory.fis.dev/artifactory/ibsdo-maven-snapshot-local/com/fis/IBS/do

	artifactory_filename   is: opstopdo

	artifactory_filetype   is: ear

	artifactory_classifier is: 

	dmserver               is: VLCAPDCCIBSDM1.fisdev.local

	update_vHost           is: yes

	vHost                  is: MD_Desktop_DO_Dev_Unit_host

	warName                is: opstopdo


5. Extract application deploy data file from Artifactory
	curl --user ****:**** -s -k -f -o /home/jenkins/workspace/IBSDO-Development/IBSDO-Development-Websphere-	DevSystem_Desktop/application_data/opstopdo.ear https://artifactory.fis.dev/artifactory/ibsdo-maven-snapshot-							local/com/fis/IBS/do/opstopdo/Aug2024.1- SNAPSHOT/opstopdo-Aug2024.1-SNAPSHOT.ear
6. Configure opstopdo.ear for specific environment
	create cmd is:mkdir /home/jenkins/workspace/IBSDO-Development/IBSDO-Development-Websphere-DevSystem_Desktop/application_data/ear_tmp

	copy cmd is:cp /home/jenkins/workspace/IBSDO-Development/IBSDO-Development-Websphere-DevSystem_Desktop/application_data/opstopdo.ear 				/home/jenkins/workspace/IBSDO-Development/IBSDO-Development-Websphere-DevSystem_Desktop/application_data/ear_tmp/opstopdo.ear

	cd to /home/jenkins/workspace/IBSDO-Development/IBSDO-Development-Websphere-DevSystem_Desktop/application_data/ear_tmp

	uncompress cmd is:jar xf opstopdo.ear

	remove cmd is:rm -f /home/jenkins/workspace/IBSDO-Development/IBSDO-Development-Websphere-DevSystem_Desktop/application_data/ear_tmp/opstopdo.ear
7. Processing war file:opstopdo.war
	create cmd is:mkdir /home/jenkins/workspace/IBSDO-Development/IBSDO-Development-Websphere-DevSystem_Desktop/application_data/ear_tmp/opstopdo

	copy cmd is:cp /home/jenkins/workspace/IBSDO-Development/IBSDO-Development-Websphere-DevSystem_Desktop/application_data/ear_tmp/opstopdo.war 			/home/jenkins/workspace/IBSDO-Development/IBSDO-Development-Websphere-DevSystem_Desktop/application_data/ear_tmp/opstopdo/opstopdo.war   

	cd to /home/jenkins/workspace/IBSDO-Development/IBSDO-Development-Websphere-DevSystem_Desktop/application_data/ear_tmp/opstopdo

	uncompress cmd is:jar xf opstopdo.war

	update vHost in directory WEB-INF 

	remove cmd is:rm -f WEB-INF/ibm-web-bnd.xmi

	move cmd is:mv WEB-INF/tmp-ibm-web-bnd.xmi WEB-INF/ibm-web-bnd.xmi

	remove cmd is:rm -f /home/jenkins/workspace/IBSDO-Development/IBSDO-Development-Websphere-									DevSystem_Desktop/application_data/ear_tmp/opstopdo/opstopdo.war

	jar cmd is:jar cfM opstopdo.war -C /home/jenkins/workspace/IBSDO-Development/IBSDO-Development-Websphere-							DevSystem_Desktop/application_data/ear_tmp/opstopdo *

	remove cmd is:rm -f /home/jenkins/workspace/IBSDO-Development/IBSDO-Development-Websphere-DevSystem_Desktop/application_data/ear_tmp/opstopdo.war

	copy cmd is:cp opstopdo.war /home/jenkins/workspace/IBSDO-Development/IBSDO-Development-Websphere-								DevSystem_Desktop/application_data/ear_tmp/opstopdo.war

	cd to /home/jenkins/workspace/IBSDO-Development/IBSDO-Development-Websphere-DevSystem_Desktop/application_data/ear_tmp

	cmd is:rm -rf /home/jenkins/workspace/IBSDO-Development/IBSDO-Development-Websphere-DevSystem_Desktop/application_data/ear_tmp/opstopdo

	jar cmd is:jar cfM opstopdo.ear -C/home/jenkins/workspace/IBSDO-Development/IBSDO-Development-Websphere-DevSystem_Desktop/application_data/ear_tmp *

	copy cmd is:cp -f /home/jenkins/workspace/IBSDO-Development/IBSDO-Development-Websphere-DevSystem_Desktop/application_data/ear_tmp/opstopdo.ear 		/home/jenkins/workspace/IBSDO-Development/IBSDO-Development-Websphere-DevSystem_Desktop/application_data/opstopdo.ear
8.  Prepare jenkins pipeline directory on target machine:vlcapdccibsdm1.fisdev.local

	cmd is:ssh -q -o StrictHostKeyChecking=no jenkins@vlcapdccibsdm1.fisdev.local rm -rf /jenkins/IBSDO-Development-deploy-DevSystem_Desktop

	ssh cmd is:ssh -q -o StrictHostKeyChecking=no jenkins@vlcapdccibsdm1.fisdev.local mkdir /jenkins/IBSDO-Development-deploy-DevSystem_Desktop

	# Copy command file to target machine:vlcapdccibsdm1.fisdev.local
	scp cmd is:scp -q -o StrictHostKeyChecking=no /home/jenkins/workspace/IBSDO-Development/IBSDO-Development-Websphere-						DevSystem_Desktop/application_data/JenkinsDeploy.ksh jenkins@vlcapdccibsdm1.fisdev.local:/jenkins/IBSDO-Development-deploy-DevSystem_Desktop

	#Copy application data to target machine:vlcapdccibsdm1.fisdev.local 
	scp cmd is:scp -q -o StrictHostKeyChecking=no /home/jenkins/workspace/IBSDO-Development/IBSDO-Development-Websphere-						DevSystem_Desktop/application_data/opstopdo.ear jenkins@vlcapdccibsdm1.fisdev.local:/jenkins/IBSDO-Development-deploy-DevSystem_Desktop

	#Copy HV_xPRES to target machine:vlcapdccibsdm1.fisdev.local
	ssh cmd is:ssh -q -o StrictHostKeyChecking=no jenkins@vlcapdccibsdm1.fisdev.local mkdir /jenkins/IBSDO-Development-deploy-DevSystem_Desktop/HV_xPRES
	scp cmd is:scp -q -o StrictHostKeyChecking=no /home/jenkins/workspace/IBSDO-Development/IBSDO-Development-Websphere-						DevSystem_Desktop/HV_xPRES/HV_xPRES.zip jenkins@vlcapdccibsdm1.fisdev.local:/jenkins/IBSDO-Development-deploy-DevSystem_Desktop/HV_xPRES

	#Unzip HV_xPRES to target machine:vlcapdccibsdm1.fisdev.local
	ssh cmd is:ssh -q -o StrictHostKeyChecking=no jenkins@vlcapdccibsdm1.fisdev.local unzip -q /jenkins/IBSDO-Development-deploy-					DevSystem_Desktop/HV_xPRES/HV_xPRES.zip -d /jenkins/IBSDO-Development-deploy-DevSystem_Desktop/HV_xPRES

	#Create HV_xPRES logs directory
	ssh cmd is:ssh -q -o StrictHostKeyChecking=no jenkins@vlcapdccibsdm1.fisdev.local mkdir /jenkins/IBSDO-Development-deploy-					DevSystem_Desktop/HV_xPRES/src/logs
	
	#Create symlinks directory
	# ssh cmd is:ssh -q -o StrictHostKeyChecking=no jenkins@vlcapdccibsdm1.fisdev.local mkdir /jenkins/IBSDO-Development-deploy-					DevSystem_Desktop/symlinks

	#Create DEPLOY link
	#ssh cmd is:ssh -q -o StrictHostKeyChecking=no jenkins@vlcapdccibsdm1.fisdev.local ln -s /jenkins/IBSDO-Development-deploy-					DevSystem_Desktop/HV_xPRES/src/bin/HarSuexecControlModule_linux /jenkins/IBSDO-Development-deploy-DevSystem_Desktop/symlinks/DEPLOY
	
	#Set permissions of HV_xPRES directory
	ssh cmd is:ssh -q -o StrictHostKeyChecking=no vlcapdccibsdm1.fisdev.local chmod -R 755 /jenkins/IBSDO-Development-deploy-DevSystem_Desktop/HV_xPRES

	#Set permissions on /jenkins/IBSDO-Development-deploy-DevSystem_Desktop/HV_xPRES/src/logs
	ssh cmd is:ssh -q -o StrictHostKeyChecking=no jenkins@vlcapdccibsdm1.fisdev.local chmod 777 /jenkins/IBSDO-Development-deploy-					DevSystem_Desktop/HV_xPRES/src/logs

	#Contents of command file /jenkins/IBSDO-Development-deploy-DevSystem_Desktop/JenkinsDeploy.ksh

	ssh cmd is:ssh -q -o StrictHostKeyChecking=no jenkins@vlcapdccibsdm1.fisdev.local cat /jenkins/IBSDO-Development-deploy-					DevSystem_Desktop/JenkinsDeploy.ksh
	#!/bin/ksh
	XPHOME=/jenkins/IBSDO-Development-deploy-DevSystem_Desktop/HV_xPRES/src; export XPHOME /usr/bin/perl /jenkins/IBSDO-Development-deploy-	DevSystem_Desktop/HV_xPRES/src/scripts/WASDeploy.pl -group IBSDO -env IBSDO -state System -owner 	wasadmin -perlPath /usr/bin/perl -debug 1 -	cluster MD_Desktop_DO_Dev_Sys -appServerList MD_Desktop_DO_Dev_Sys_VLCAPDCCIBSAPP2:VLCAPDCCIBSAPP2_base1_	node2 -wsDMProfileBase 	/opt/WebSphere/9/DeploymentManagers -wsDMProfile DeploymentManager_System -vHost MD_Desktop_DO_Dev_Sys_host -	wsDeployedEarPath 	/opt/WebSphere/9/AppServerBase1/profiles/AppServerBase2/installedApps/System_Cell/opstopdo_Dev.ear -appName opstopdo_Dev -	wsDeployOwner 	wasadmin -cellName System_Cell -wsASBProfileBase /opt/WebSphere/9/AppServerBase1/profiles -warName opstopdo -appServerBase 	AppServerBase1 -	deployedEarPerms 775:774:Yes:Dev, Unit_Test, System_Test, UAT, Readiness ::: 775:774:No:Client_Test, Production, eProduction -	delayStartList 10:2, 	40:5, 50:7, 60:10, 100:20 -delayPostJVMStart 2 -delayMapWebModuleToServers 0 -boksPath /usr/boksm/bin -webModule opstopdo_Dev -	cClassLoaderMode 	appwarLevel -cWarClassLoadPol false -startStopByCluster 1 -symlinkList 	/opt/WebSphere/9/AppServerBase1/profiles/AppServerBase2/installedApps/System_Cell/opstopdo_Dev.ear/opstopdo.war, /md_authoring/ga/do/AuthoredRules, 	AuthoredRules ::: /opt/WebSphere/9/AppServerBase1/profiles/AppServerBase2/installedApps/System_Cell/opstopdo_Dev.ear/opstopdo.war/WEB-INF/lib, 	/application/DO_Desktop/EnvJars, DevSystem -server vlcapdccibsdm1.fisdev.local -ermPath /jenkins/IBSDO-Development-deploy-DevSystem_Desktop -	baseLogName IBSDO-Development-deploy-DevSystem_Desktop -logPath /jenkins/IBSDO-Development-deploy-DevSystem_Desktop/HV_xPRES/src/logs -logFile 	/jenkins/IBSDO-Development-deploy-DevSystem_Desktop/HV_xPRES/src/logs/IBSDO-Development-deploy-DevSystem_Desktop-DP.log -symlinkPath /jenkins/IBSDO-	Development-deploy-DevSystem_Desktop/symlinks -wsDMJCLFile /jenkins/IBSDO-Development-deploy-	DevSystem_Desktop/HV_xPRES/src/was/jacl/wasDeployLib.jacl -earFile /jenkins/IBSDO-Development-deploy-DevSystem_Desktop/opstopdo.ear

9. Launch deploy command on target machine:vlcapdccibsdm1.fisdev.local
ssh cmd is:ssh -q -o StrictHostKeyChecking=no wasadmin@vlcapdccibsdm1.fisdev.local /jenkins/IBSDO-Development-deploy-DevSystem_Desktop/JenkinsDeploy.ksh
