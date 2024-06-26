#!/usr/bin/groovy
def call(Map params = [:]) {

def buildParamsYAMLFile = params.buildParamsYAML
def timeIt = params.timeIt
def timeStamp = Calendar.getInstance().getTime().format('MM/dd/YYYY',TimeZone.getTimeZone('CST'))

def webHook, appName, openShiftProjectName, versionNumber, images, slaveTemplate, cloudId, namespace, workingdir, jenkinsClient, mavenImage, blackDuckURL, blackduckProjectName, blackDuckCredentialsId, blackduckDetectJar, notificationEmail = ""

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
                  def pom = readMavenPom file: 'pom.xml'
					def vars = readYaml file: buildParamsYAMLFile
                    appName = vars.buildParams.appName
                    blackduckProjectName = vars.buildParams.blackDuck.blackduckProjectName
                    notificationEmail = vars.buildParams.notificationEmail
					blackduckscaninput = vars.buildParams.blackduckscan
					openShiftProjectName = vars.buildParams.openShiftProjectName
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
					blackDuckCredentialsId = pipelineConfig.buildParams.blackDuck.blackDuckCredentialsId
					blackDuckURL = pipelineConfig.buildParams.blackDuck.blackDuckURL
					blackduckDetectJar = pipelineConfig.buildParams.blackDuck.blackduckDetectJar
					images = [jnlp:jenkinsClient, maven:mavenImage, mavenCpuLmt:"1", mavenMemLmt:"1Gi"]
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
                                    
                                    stash includes: '**/**.jar, **/**.ear, **/**.zip', name: 'artifact'
                                }
                            }
                        }
                    }
                }
		}
        stage ("BlackDuck Scan"){
			steps {
				script {
					
				if (blackduckProjectName != "") {
					echo "BlackDuck Scan Submitting"
					withCredentials([string(credentialsId: "${blackDuckCredentialsId}", variable: 'blackducktoken')]) {
						println "BlackDuck Scan"
						unstash 'artifact'
						withEnv(["PATH+MAVEN=/opt/apache-maven-3.2.5/bin"]) {
						sh """
								ls -lart
							curl -o detect.jar "${blackduckDetectJar}"
							chmod 777 detect.jar
							java -jar detect.jar  \
							--blackduck.url="${blackDuckURL}" \
							--blackduck.api.token="${blackducktoken}" \
							--detect.project.name="${blackduckProjectName}" \
							--detect.project.version.name="${blackduckProjectName}" \
							--detect.project.codelocation.suffix="${env.BRANCH_NAME}" \
							--detect.source.path='src'
							"""
						}
					}
				}
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
			message: "Scan Upload Successful.  Version: ${parentversion}",
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
			message: "Scan Upload Failed.   Version: ${parentversion}",
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
