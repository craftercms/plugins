import  scripts.plugins.alfresco.activiti.Activiti

def activitiUserName = null
def activitiPassword = null

if(profile) {
	activitiUserName = profile.activitiUserName
	activitiPassword = profile.activitiPassword
}

def activitiAPI = new Activiti(activitiUserName, activitiPassword, logger, siteConfig)

return activitiAPI.getProcessDefs()