#!/usr/bin/groovy
def call(Map params = [:]) {

def buildParamsYAMLFile = params.buildParamsYAML

def openShiftProjectName, versionNumber, images, slaveTemplate, cloudId, namespace, mavenMem, workingdir, jenkinsClient, mavenImage, blackDuckURL, blackduckProjectName, blackDuckCredentialsId, blackduckDetectJar, veracodeAppName, veracodeCredentialsId, notificationEmail = ""

properties([disableConcurrentBuilds(),buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '10')),
parameters([
		choice(choices: ["ibsact", "ibscc", "ibscm", "ibsdo", "ibsmb", "ibssrm", "ibswqm", "ibsusrpref", "ibsinstjrs", "ibsinsight", "ibshmpg", "ibsxcpproc", "ibsentlmnt", "ibscicis", "ibsproc", "ibsrlp", "ibsdg", "ibssg"], description: 'Select Project ID', name: 'projectID')
	])

])

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
					openShiftProjectName = projectID
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

					echo "project id is: " + projectID
                  
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
									
									sh "rm -rf /data/.m2/repository/*"
                                    
                                }
                            }
                        }
                    }
                }
                post {
				success{
					script {
						println "Cache dumped successfully!! Please review Build Logs"
					}
				}
                failure {
                    script{
						println "Failed !! Please review Build Logs"
					}
				}
			}
		}
	}
	post {
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
