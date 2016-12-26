import scripts.crafter.ext.activiti.Activiti

def activitiUserName = null
def activitiPassword = null
def procs = []

if(profile) {
	activitiUserName = profile.activitiUserName
	activitiPassword = profile.activitiPassword
}

def activitiAPI = new Activiti(activitiUserName, activitiPassword, logger, siteConfig)

def activitiProcs = activitiAPI.getProcessDefs()

activitiProcs.data.each {  proc -> 
	def item = [:]
    item.name = proc.name 
    item.id = proc.id
    procs.add(item)
}

def results = [:]
results = procs

return results

