#!/usr/bin/groovy
def call(Map params = [:]) {

def buildParamsYAMLFile = params.buildParamsYAML
def timeIt = params.timeIt
def timeStamp = Calendar.getInstance().getTime().format('MM/dd/YYYY',TimeZone.getTimeZone('CST'))

//boolean isBlackDuckScan = "false", isVeracodeScan = "false" 

def appName, openShiftProjectName, versionNumber, images, slaveTemplate, cloudId, namespace, workingdir, jenkinsClient, mavenImage, blackDuckURL, blackduckProjectName, blackDuckCredentialsId, blackduckDetectJar, veracodeAppName, veracodeCredentialsId, notificationEmail = ""

properties([disableConcurrentBuilds(),buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '10'))])
 
pipeline {
    agent {
		label "dind18"
	}
    environment {
        branchName = "${env.BRANCH_NAME}"
		label = "pod-${UUID.randomUUID().toString()}" 
    }
 
	parameters{
		booleanParam(defaultValue: "false", description: 'Run Veracode Scan', name: 'isVeracodeScan')
		booleanParam(defaultValue: "false", description: 'Run Black Duck Scan', name: 'isBlackDuckScan')
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
                    appName = vars.buildParams.appName
                    veracodeAppName = vars.buildParams.veracode.veracodeAppName
                    blackduckProjectName = vars.buildParams.blackDuck.blackduckProjectName
                    notificationEmail = vars.buildParams.notificationEmail
					openShiftProjectName = vars.buildParams.openShiftProjectName
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
					veracodeCredentialsId = pipelineConfig.buildParams.veracode.veracodeCredentialsId
					blackDuckCredentialsId = pipelineConfig.buildParams.blackDuck.blackDuckCredentialsId
					blackDuckURL = pipelineConfig.buildParams.blackDuck.blackDuckURL
					blackduckDetectJar = pipelineConfig.buildParams.blackDuck.blackduckDetectJar
					images = [jnlp:jenkinsClient, maven:mavenImage, mavenCpuLmt:"1", mavenMemLmt:"4Gi"]
					slaveTemplate = new PodTemplates(cloudId, namespace, label, images, workingdir, this)
                  //	isVeracodeScaninput = params.isVeracodeScan
				//	veracodescaninput = vars.buildParams.veracodescan
                 //   isBlackDuckScan = vars.buildParams.isBlackDuckScan
					//blackduckscaninput = vars.buildParams.blackduckscan
                  
                    echo "Veracode Scan manual parameter IS: " + isVeracodeScan.toBoolean()
                    echo "BlackDuck Scan manual parameter IS: " + isBlackDuckScan.toBoolean()


                   // if (veracodescaninput == "true" || isVeracodeScan.toBoolean() ){ veracodeScan = true } else { veracodeScan = false }
					//if (blackduckscaninput == "true" || isBlackDuckScan.toBoolean() ){ blackDuckScan = true } else { blackDuckScan = false }
					//echo veracodeScan.toString()
					//echo blackDuckScan.toString()
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
                                        sh "mvn -V -B -f pom.xml clean install"
                                    }
                                  def pom = readMavenPom file: 'pom.xml'
                                 versionNumber = pom.parent.version 
                                    
                                    stash includes: '**/**.jar, **/**.ear, **/**.zip', name: 'artifact'
                            
                                }
                            }
                        }
                    }
                }
               post {
				success{
					script {
						currentBuild.description = "Built Version : ${versionNumber}"
					}
				}
                failure {
                    script{
						println "Build Failed !! Please review Build Logs"
					}
				}
			} 
		}
        stage ("SCA"){
			parallel{
				stage('Veracode Scan') {
                 
					when {
						expression {isVeracodeScan.toBoolean()}
					}
					steps {
						script {
                            echo "Veracode Scan Submitting"
							withCredentials([usernamePassword(credentialsId: veracodeCredentialsId, usernameVariable: "USERNAME", passwordVariable: "PASSWORD")]) {
								println "VeraCode Scan"
								unstash 'artifact'
								veracode applicationName: "${veracodeAppName}",  \
								//createSandbox: true,
                              	debug: true,  \
								sandboxName: "${appName}:${branchName}",  \
								scanExcludesPattern: '',  \
								scanIncludesPattern: '',  \
								scanName: "${veracodeAppName}_${timeStamp}_${BUILD_ID}",  \
								uploadExcludesPattern: '',  \
								uploadIncludesPattern: '**/**.jar,**/**.zip',  \
								vid: "$USERNAME",  \
								vkey: "$PASSWORD"
									
							}
						}
					}
					post {
						failure {
							script{
								println "VeraCode Scan failed for ${versionNumber}"
							}
						}
					}
				}
				stage('BlackDuck Scan') {
					when {
						expression {isBlackDuckScan.toBoolean()}
					}
					steps {
						script {
                            echo "BlackDuck Scan Submitting"
							withCredentials([string(credentialsId: "${blackDuckCredentialsId}", variable: 'blackducktoken')]) {
								println "BlackDuck Scan"
								unstash 'artifact'
								sh """
		                            ls -lart
		                            curl -o detect.jar "${blackduckDetectJar}"
		                            chmod 777 detect.jar
		                            java -jar detect.jar  \
		                            --blackduck.url="${blackDuckURL}" \
		                            --blackduck.api.token="${blackducktoken}" \
		                            --detect.project.name="${blackduckProjectName}" \
		                            --detect.project.version.name="${blackduckProjectName}:${env.BRANCH_NAME}" \
		                            --detect.project.codelocation.suffix="${env.BRANCH_NAME}" \
		                            --detect.source.path=.
                                    --detect.force.success=true
                                    --blackduck.trust.cert=true 
		                            --detect.tools=DETECTOR 
		                            --logging.level.com.synopsys.integration=INFO 
		                            --min-scan-interval=0 
	                              """
                                }
						}
					}
					post {
						failure {
							script{
								println "BlackDuck Scan failed for ${versionNumber}"
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
