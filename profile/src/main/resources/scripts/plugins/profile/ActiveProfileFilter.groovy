package scripts.plugins.profile

import scripts.plugins.profile.ProfileServices

/**
 * This filter looks at the incoming headers and loads up the appropriate user
 */
String UNSET_VALUE = "UNSET"
def userProfile = null
def isPreview = false
def force403 = (params["force403"] != null) ? true : false
def skipFilterForUri = false

def profileServices = new ProfileServices(applicationContext, request, response, logger)
def userValues = null

def skipFilterForUri = determineIfSkipFilterForUri(request)


if(skipFilterForUri==false) {
    userProfile = createProfile(profileServices, userValues, isPreview)

    profileServices.setActiveProfile(userProfile)

    filterChain.doFilter(request, response)
}
else {
    filterChain.doFilter(request, response)
}



/* =========================================================== */
//   Helper Methods Below
/* =========================================================== */

/**
 * Create Profile
 */
private Object createProfile(profileServices, userValues, isPreview) {
    def userProfile =  null
    def userName = userValues.userName
    def firstName = userValues.firstName
    def lastName = userValues.lastName
    def email = userValues.email

    userProfile = profileServices.createProfile(userName, firstName, lastName, email)

    // load non SSO properties from profile store (cookies, crafterProfile... whatever
    userProfile = profileServices.loadPropertiesFromProfileStore(userValues.userName, userProfile)

    return userProfile
}

/**
 * this method should be empty because the config should handle this
 */
private boolean determineIfSkipFilterForUri(request) {
    def skipFilter = false

    if(request.requestURI.startsWith("/api/1/profile")
            || request.requestURI.startsWith("/api/1/site")
            || request.requestURI.startsWith("/api/1/content")
            || request.requestURI.startsWith("/static-assets/error-pages")) {
        skipFilter = true
    }

    return skipFilter
}

/**
 * Determine if the filter is running in preview mode or not
 */
private boolean determineIfPreview(applicationContext) {
    def isPreview = false

    try {
        isPreview = (applicationContext.get("crafter.authoringOverlayCallback") != null)
    }
    catch(exceptionThrownWhenNotInPreview) {
        // dear engine, throwing an exception is a little harsh
    }

    return isPreview
}

/**
 * log function, looks weird but just just want a quick way to shut these off
 */
private void logInfo(logger, message) {
    def doInfoLogging = true

    if(doInfoLogging == true) {
        logger.info("ACTIVE PROFILE FILTER: " + message)
    }
}