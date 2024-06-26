#!/usr/bin/groovy
def call(Map params = [:]) {

def buildParamsYAMLFile = params.buildParamsYAML
def timeIt = params.timeIt
def timeStamp = Calendar.getInstance().getTime().format('MM/dd/YYYY',TimeZone.getTimeZone('CST'))

def webHook, CXGroupID, parentversion, scanVersion, openShiftProjectName, images, slaveTemplate, cloudId, namespace, workingdir, jenkinsClient, mavenImage, checkmarxAppName, checkmarxURL, notificationEmail = ""

properties([disableConcurrentBuilds(),buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '10'))])

pipeline {
    agent {
		label "jdk8"
	}
   triggers{ cron( getParams(timeIt) ) }
    environment {
        branchName = "${env.BRANCH_NAME}"
		label = "pod-${UUID.randomUUID().toString()}" 
    }
	options {
		timestamps()
    }
    stages {
          stage('Start Declarative Pipeline') {
            steps {
                script {
                    echo "Pipeline Started"
					def vars = readYaml file: buildParamsYAMLFile					
					def pom = readMavenPom file: 'pom.xml'
                    parentversion = pom.parent.version
                    checkmarxAppName = vars.buildParams.checkmarx.checkmarxAppName
                    notificationEmail = vars.buildParams.notificationEmail
					openShiftProjectName = vars.buildParams.openShiftProjectName
                  	CXGroupID = vars.buildParams.checkmarx.groupid
                    webHook = vars.buildParams.webhook
                    println "openShiftProjectName: ${openShiftProjectName}"
                    cloudConfig = readYaml(text: libraryResource('com/fis/ibs/ocproject.yml'))
                    cloudId = cloudConfig."${openShiftProjectName}".cloudId
    				namespace = cloudConfig."${openShiftProjectName}".namespace
					println "cloudId:" + cloudConfig."${openShiftProjectName}".cloudId
					println "namespace:" + cloudConfig."${openShiftProjectName}".namespace
                    println "timeStamp: ${timeStamp}"
                    println "timeit cron value: ${timeIt}"
                    mavenImage = cloudConfig."${openShiftProjectName}".mavenImage
					def pipelineConfig = fetchPipelineConfig()
					jenkinsClient = pipelineConfig.buildParams.jenkinsSonarImage
					workingdir = pipelineConfig.buildParams.workingdir
					scanVersion = pipelineConfig.buildParams.scanversion
                    checkmarxURL = pipelineConfig.buildParams.checkmarx.checkmarxURL
					images = [jnlp:jenkinsClient, maven:mavenImage, mavenCpuLmt:"1", mavenMemLmt:"1500Mi"]
					slaveTemplate = new PodTemplates(cloudId, namespace, label, images, workingdir, this)
                    println "Checkmarx URL: ${checkmarxURL}"
				}
			}
		}
		stage('Maven Build') {
			steps{
				script {
                    echo "Maven Build Started"
                    echo "Container images: ${images}"
		            echo "running agents on node with label ${label}"
                    slaveTemplate.BuilderTemplate {
                        node(slaveTemplate.podlabel) {							
                                container("maven"){
                                    cleanWs()
                                    milestone()
                                    try {
                                        checkout scm
                                    }
                                    catch(e) {
                                        currentBuild.result = "ABORTED"
                                        def latestcommitHash = sh(script: "git rev-parse origin/${branchName}", returnStdout: true).trim()
                                        println "Latest commit hash: ${latestcommitHash}"
                                        error('!!!! Git commit hash code differs cannot continue with build !!!!')
                                    }                    
										sh "mvn -V -B -U -f pom.xml clean deploy"
                  						def pom = readMavenPom file: 'pom.xml'
                                   		parentversion = pom.parent.version

                                  	// Stash everything needed for checkmarx
                                   stash includes: '**/**.java, **/**.jsp, **/**.js, **/**.xml, **/**.xsl, **/**.html', name: 'artifact'
                                }
                            }
                        }
                    }
                }
               
		}
        stage('Checkmarx Scan') {
			steps{
				script {
                    println "Checkmarx Scan"
					unstash 'artifact'
				  step([
                    $class: 'CxScanBuilder', 
                    comment: '', 
                    credentialsId: 'IBSSAS_Checkmarx', 
                    customFields: '', 
                    excludeFolders: '', 
                    exclusionsSetting: 'job', 
                    excludeFolders: '.git, Checkmarx', 
                    failBuildOnNewResults: false, 
                    failBuildOnNewSeverity: 'HIGH', 
                    fullScanCycle: 10, 
                    groupId: "${CXGroupID}", 
                    password: '{AQAAABAAAAAQ7PjPyyhz97fS4tqOX0WeTNITJkY804/OS5OvSPTz+bs=}', 
                    preset: '100000', 
                    projectName: "${checkmarxAppName}", 
                    sastEnabled: true, 
                    serverUrl: "${checkmarxURL}", 
                    sourceEncoding: '1', 
                    useOwnServerCredentials: true, 
                    username: '', 
                    vulnerabilityThresholdResult: 'FAILURE', 
                    waitForResultsEnabled: false
                    ])
                    }
                }
                        }
       
		}
        post {
		always {
			deleteDir()
			script{
				buildNotification {
					emailId = notificationEmail
				}
			}	
		}
		success {
			script{
			echo "Success"
			enaNotifiers.notifyMicrosoftTeams(
			webhookUrls: webHook,
			message: "Scan Upload Successful. Version: ${parentversion}",
			status: "SUCCESS",
			color: "green"
				)
          }
		}
		unstable {
			echo "Unstable"
		}
		failure {
			script {
			echo "Failure"
			enaNotifiers.notifyMicrosoftTeams(
			webhookUrls: webHook,
			message: "Scan Upload Failed. Version: ${parentversion}",
			status: "FAILURE",
			color: "red"
				)
          }
		}
	} 
	}
	
}


def getParams(timeIt) {
        return timeIt
}
