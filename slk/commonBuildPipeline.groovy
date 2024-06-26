#!/usr/bin/groovy
def call(Map params = [:]) {

def buildParamsYAMLFile = params.buildParamsYAML

def openShiftProjectName, versionNumber, images, slaveTemplate, cloudId, namespace, mavenMem, workingdir, jenkinsClient, mavenImage, blackDuckURL, blackduckProjectName, blackDuckCredentialsId, blackduckDetectJar, veracodeAppName, veracodeCredentialsId, notificationEmail = ""

properties([disableConcurrentBuilds(),buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '10'))])

pipeline {
    agent {
		label "dind18"
	}
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
                    notificationEmail = vars.buildParams.notificationEmail
					openShiftProjectName = vars.buildParams.openShiftProjectName
                    println "openShiftProjectName: ${openShiftProjectName}"
                    cloudConfig = readYaml(text: libraryResource('com/fis/ibs/ocproject.yml'))
                    cloudId = cloudConfig."${openShiftProjectName}".cloudId
    				namespace = cloudConfig."${openShiftProjectName}".namespace
                    mavenMem = cloudConfig."${openShiftProjectName}".mavenMemory
					println "cloudId:" + cloudConfig."${openShiftProjectName}".cloudId
					println "namespace:" + cloudConfig."${openShiftProjectName}".namespace
					println "mavenMem:" + cloudConfig."${openShiftProjectName}".mavenMem
                    mavenImage = cloudConfig."${openShiftProjectName}".mavenImage
					def pipelineConfig = fetchPipelineConfig()
					jenkinsClient = pipelineConfig.buildParams.jenkinsSonarImage
					workingdir = pipelineConfig.buildParams.workingdir
					images = [jnlp:jenkinsClient, maven:mavenImage, mavenCpuLmt:"1", mavenMemLmt:mavenMem ]
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
                                                                        
                                    if (branchName == "develop" || branchName == "master" || branchName.contains("release")){
                                        sh "mvn -V -B -U -f pom.xml clean deploy"
                                    }
                                    else{
                                        sh "mvn -V -B -U -f pom.xml clean install"
                                    }
                                    def pom = readMavenPom file: 'pom.xml'
                                    versionNumber = pom.version 
                                  	parentversion = pom.parent.version
                                    
                                }
                            }
                        }
                    }
                }
                post {
				success{
					script {
						currentBuild.description = "Built Version : ${parentversion}"
					}
				}
                failure {
                    script{
						println "Build Failed !! Please review Build Logs"
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
			echo "Success"
		}
		unstable {
			echo "Unstable"
		}
		failure {
			echo "Failure"
		}
	} 
}
}
