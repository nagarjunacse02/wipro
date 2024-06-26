#!/usr/bin/groovy
def call(Map params = [:]) {

def buildParamsYAMLFile = params.buildParamsYAML
def timeIt = params.timeIt
def timeStamp = Calendar.getInstance().getTime().format('MM/dd/YYYY',TimeZone.getTimeZone('CST'))

def webHook, cxoneid, cxprojectname, parentversion, scanVersion, openShiftProjectName, images, slaveTemplate, cloudId, namespace, workingdir, jenkinsClient, mavenImage, checkmarxURL, notificationEmail = ""

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
                    notificationEmail = vars.buildParams.notificationEmail
					openShiftProjectName = vars.buildParams.openShiftProjectName
                    webHook = vars.buildParams.webhook
					cxoneid = vars.buildParams.CxOne.CxOneID
					cxprojectname = vars.buildParams.CxOne.CxOneProjectName
                    println "openShiftProjectName: ${openShiftProjectName}"
                    cloudConfig = readYaml(text: libraryResource('com/fis/ibs/ocproject.yml'))
                    cloudId = cloudConfig."${openShiftProjectName}".cloudId
    				namespace = cloudConfig."${openShiftProjectName}".namespace
					println "cloudId:" + cloudConfig."${openShiftProjectName}".cloudId
					println "namespace:" + cloudConfig."${openShiftProjectName}".namespace
                    println "timeStamp: ${timeStamp}"
                    println "timeit cron value: ${timeIt}"
					println "cxoneid: ${cxoneid}"
					println "cxprojectname: ${cxprojectname}"
                    mavenImage = cloudConfig."${openShiftProjectName}".mavenImage
					def pipelineConfig = fetchPipelineConfig()
					jenkinsClient = pipelineConfig.buildParams.jenkinsSonarImage
					workingdir = pipelineConfig.buildParams.workingdir
					scanVersion = pipelineConfig.buildParams.scanversion
                    checkmarxURL = pipelineConfig.buildParams.checkmarx.checkmarxURL
					images = [jnlp:jenkinsClient, maven:mavenImage, mavenCpuLmt:"1", mavenMemLmt:"1500Mi"]
					slaveTemplate = new PodTemplates(cloudId, namespace, label, images, workingdir, this)
					
        
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
                                   stash includes: '**/**.zip, **/**.jar', name: 'artifact'
                                 //  stash includes: '**/**.class, **/**.jsp, **/**.js, **/**.xml, **/**.xsl, **/**.html', name: 'artifact'
                                }
                            }
                        }
                    }
                }
               
		}
        stage('CxOne Scan') {
			steps{
	                sh "curl -v -L -o ScaResolver-linux64.tar.gz https://sca-downloads.s3.amazonaws.com/cli/2.6.3/ScaResolver-linux64.tar.gz"
                    sh "tar -xvf ScaResolver-linux64.tar.gz -C ${WORKSPACE}"
                    sh "rm -rf ScaResolver-linux64.tar.gz"
                    sh "readlink -f ScaResolver"
                    println "CxOne Scan"
					unstash 'artifact'
                    checkmarxASTScanner( 
                    baseAuthUrl: '', 
                    branchName: 'Release',
                    checkmarxInstallation: 'CxASTCLI', 
                    projectName: cxprojectname, 
                    credentialsId: cxoneid, 
                    serverUrl: 'https://fis.cxone.cloud', 
                    tenantName: 'fis', 
					useOwnAdditionalOptions: true,
                    useOwnServerCredentials: true,
					additionalOptions: '--sca-resolver "${WORKSPACE}/ScaResolver" --debug --sca-resolver-params "-e pom.xml --extract-archives ear,war,zip,jar --extract-depth=15"'
					)
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
