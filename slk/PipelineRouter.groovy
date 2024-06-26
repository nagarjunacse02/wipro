#!/usr/bin/groovy
def call(Map config = [:]) {
    def checkRoute = config.route

		if (checkRoute.matches("commonbuild")) {
			commonBuildPipeline(config)
		}
  		else if (checkRoute.matches("veracode_policy")) {
			veracodepolicyPipeline(config)         
		}
		else if (checkRoute.matches("partial_scan")) {
			scanspartappPipeline(config)         
		}
		else if (checkRoute.matches("2gi_policy")) {
			veracodepolicy2gPipeline(config)         
		}
		else if (checkRoute.matches("veracode_sandbox")) {
			veracodeSandboxPipeline(config)         
		}
		else if (checkRoute.matches("partial_2g")) {
			scanspartapp2gPipeline(config)         
		}
		else if (checkRoute.matches("common_2g")) {
			commonBuildPipeline2g(config)         
		}
		else if (checkRoute.matches("CXProd")) {
			CXProdScan(config)         
		}else if (checkRoute.matches("BDProd")) {
			BDProdScan(config)         
		}else if (checkRoute.matches("CxOne")) {
			CxOneScan(config)         
		}else if (checkRoute.matches("cache")) {
			cacheDump(config)         
		}
}
