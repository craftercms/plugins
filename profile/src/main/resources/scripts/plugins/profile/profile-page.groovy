import scripts.plugins.profile.ProfileServices

def profileServices = new ProfileServices(applicationContext, request)

def userProfile = profileServices.getActiveProfile()
