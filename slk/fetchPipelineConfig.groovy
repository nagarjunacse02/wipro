#!/usr/bin/groovy

def call() {
	def pipelineYAML = libraryResource('com/fis/ibs/ocpBuildParameters.yml')
	echo pipelineYAML
	Map pipelineConfig = readYaml(text: pipelineYAML)
	return pipelineConfig
}