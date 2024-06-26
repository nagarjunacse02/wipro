#!/usr/bin/groovy

def call() {
   def buildCauses = currentBuild.getBuildCauses()
	boolean isStartedByTimer = false
	for (buildCause in buildCauses) {
		if ("${buildCause}".contains("Started by timer")) {
			isStartedByTimer = true
		}
	}
	return isStartedByTimer
}