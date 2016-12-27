import scripts.plugins.profile.ProfileServices

def profileServices = new ProfileServices(applicationContext, request)

templateModel.userProfile = profileServices.getActiveProfile()