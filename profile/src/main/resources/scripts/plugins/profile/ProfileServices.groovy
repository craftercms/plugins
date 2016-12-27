package scripts.plugins.profile

import javax.servlet.http.Cookie
import java.util.UUID
import org.craftercms.profile.api.exceptions.ProfileException

import scripts.model.to.UserProfile

public class ProfileServices {

    private boolean sessionCachingEnabled = true
    private String PROFILE = "PROFILE"
    private String DEFAULT_EMAIL = "noreply"

    private Object logger = null
    private Object request = null
    private Object response = null
    private Object context = null
    private String profileTenantName = ""
    private String socialContextId = ""
    private String socialContextName = ""
    private boolean backWithCrafterProfile = true

    public ProfileServices(applicationContext, request, response, logger) {
        this.context = applicationContext
        this.request = request
        this.response = response
        this.logger = logger
    }

    public UserProfile createProfile(userName, firstName, lastName, email, roleID, region, onPropertyStatus, targetingHints) {
        def profile = null

        profile = new UserProfile(userName, firstName, lastName, email, roleID, region, onPropertyStatus, targetingHints)


        return profile
    }

    public UserProfile loadPropertiesFromProfileStore(String userName, UserProfile profileTo) {

        def isPreview = determineIfPreview(this.context)

        if(isPreview == false) {
            def createProfileFlag = false
            def crafterProfile = null
            def crafterProfileService = this.context.get("crafter.profileServiceRestClient")
            def crafterProfileAuthService = this.context.get("crafter.authenticationServiceRestClient")
            def email = ""

            // TRY AND GET A PROFILE FROM CACHE AND QUIT EARLY IF POSSIBLE
            // :-/ Multiple return statements
            def cachedProfile = this.getCachedProfile()

            if(cachedProfile != null) {
                this.logInfo("Using cached profile for user: [" + userName + "]")
                profileTo = cachedProfile
                return profileTo
            }

            try {
                crafterProfile = crafterProfileService.getProfileByUsername(this.profileTenantName, userName)

                if(crafterProfile != null) {
                    def cpProfileId        = ""+crafterProfile.getId()
                    def cpPreferredName    = crafterProfile.getAttributes().get("marPreferredName")
                    def cpOfficePhone      = crafterProfile.getAttributes().get("marOfficePhone")
                    def cpMobilePhone      = crafterProfile.getAttributes().get("marMobilePhone")
                    def cpSkypeId          = crafterProfile.getAttributes().get("marSkypeId")
                    def cpLinkedInId       = crafterProfile.getAttributes().get("marLinkedInId")


                    if(cpProfileId        != null && !"".equals(cpProfileId))         profileTo.setCrafterProfileId(cpProfileId)
                    if(cpPreferredName    != null && !"".equals(cpPreferredName))     profileTo.setPreferredName(cpPreferredName)
                    if(cpOfficePhone      != null && !"".equals(cpOfficePhone))       profileTo.setOfficePhone(cpOfficePhone)
                    if(cpMobilePhone      != null && !"".equals(cpMobilePhone))       profileTo.setMobilePhone(cpMobilePhone)
                    if(cpSkypeId          != null && !"".equals(cpSkypeId))           profileTo.setSkypeId(cpSkypeId)
                    if(cpLinkedInId       != null && !"".equals(cpLinkedInId))        profileTo.setLinkedInId(cpLinkedInId)

                    if( !this.DEFAULT_EMAIL.equals(crafterProfile.getEmail()) ) {//Done set if is the default email
                        profileTo.setEmail(crafterProfile.getEmail()) // use can manage this attribute
                    }

                    // ONLY CACHE PROFILE ON READ FROM DB
                    this.cacheProfile(profileTo)
                }
                else {
                    createProfileFlag = true
                }
            }
            catch(ProfileException profileNotFoundErr) {
                createProfileFlag = true
            }

            if(createProfileFlag == true) {
                try {
                    def defaultEmail = this.DEFAULT_EMAIL
                    email = ("NOT_FOUND".equals(profileTo.getEmail()) || "UNSET".equals(profileTo.getEmail()) ) ? defaultEmail :  profileTo.getEmail()

                    def firstName = (profileTo.getFirstName() != null && !"UNSET".equals(profileTo.getFirstName())) ? profileTo.getFirstName() : ""
                    def lastName  = (profileTo.getLastName()  != null && !"UNSET".equals(profileTo.getLastName()))  ? profileTo.getLastName()  : ""
                    def displayName = (firstName + " " + lastName).toUpperCase()

                    java.util.Set<String> profileRoles = new java.util.HashSet<String>()
                    profileRoles.add("SOCIAL_USER")

                    def socialContexts = []

                    def socialContextThePlatform = [:]
                    socialContextThePlatform.id = this.socialContextId
                    socialContextThePlatform.name = this.socialContextName
                    socialContextThePlatform.roles = new java.util.HashSet<String>()
                    socialContextThePlatform.roles.add("SOCIAL_USER")
                    socialContextThePlatform.roles.add("SOCIAL_AUTHOR")
                    socialContexts.add(socialContextThePlatform)

                    java.util.Map<String, Object> profileAttributes = new java.util.HashMap<String, Object>()
                    profileAttributes.put("socialContexts", socialContexts)
                    profileAttributes.put("displayName", displayName)

                    crafterProfile = crafterProfileService.createProfile(this.profileTenantName, profileTo.getUserName(), ""+UUID.randomUUID(), email, true, profileRoles, profileAttributes, "")
                    def cpProfileId = "" + crafterProfile.getId()
                    if(cpProfileId != null && !"".equals(cpProfileId)) profileTo.setCrafterProfileId(cpProfileId)

                }
                catch(Exception err) {
                    throw new Exception(""+err)
                }
            }

            if(crafterProfile != null) {
                // check for existing ticket
                def ticket = null
                def createNewTicket = false
                def requestCookies = this.request.getCookies()

                for(Cookie c : requestCookies){
                    if(c.getName().equals("ticket")) {
                        ticket = c.getValue()
                        break
                    }
                }

                if(ticket == null) {
                    createNewTicket = true
                }

                if(createNewTicket == true) {
                    ticket = crafterProfileAuthService.createTicket(""+crafterProfile.getId())

                    Cookie authTicketCookie = new Cookie("ticket", ticket.getId())
                    authTicketCookie.setMaxAge(60*60)
                    authTicketCookie.setPath("/")
                    this.response.addCookie(authTicketCookie)
                }

                // check for social context
                def profileAttibutes = crafterProfile.getAttributes()
                def socialContexts = profileAttibutes.get("socialContexts")

                def platformContexContextFound = false
                socialContexts.each { socialContext ->
                    if(socialContext.id.equals(this.socialContextId)) {
                        platformContexContextFound = true
                    }
                }

                if(platformContexContextFound == false) {
                    // update profile with social context
                    def attributesToUpdate = [:]

                    def socialContextThePlatform = [:]
                    socialContextThePlatform.id = this.socialContextId
                    socialContextThePlatform.name = this.socialContextName
                    socialContextThePlatform.roles = new java.util.HashSet<String>()
                    socialContextThePlatform.roles.add("SOCIAL_USER")
                    socialContextThePlatform.roles.add("SOCIAL_AUTHOR")
                    socialContexts.add(socialContextThePlatform)

                    // use an empty map with only our attribtue so other attributes are left alone
                    attributesToUpdate["socialContexts"] = socialContexts

                    crafterProfile = crafterProfileService.updateAttributes(""+crafterProfile.getId(), attributesToUpdate)
                }
            }
        }
        else {

            // load properties from cookies

            def requestCookies = this.request.getCookies()
            profileTo = pupulateUserProfileWithFakeData(profileTo)

        }

        return profileTo
    }

    public boolean updateProfile(UserProfile profileTo) {
        def status = false
        def isPreview = determineIfPreview(this.context)

        if(isPreview == false) {
            def crafterProfileService = this.context.get("crafter.profileServiceRestClient")
            def crafterProfile = crafterProfileService.getProfileByUsername(this.profileTenantName, profileTo.getUserName())

            if(crafterProfile!=null) {
                java.util.Map<String, Object> profileAttributes = new java.util.HashMap<String, Object>()

                if(profileTo.getTitle() != null)            profileAttributes.put("marTitle",            profileTo.getTitle())
                if(profileTo.getPreferredName() != null)    profileAttributes.put("marPreferredName",    profileTo.getPreferredName())
                if(profileTo.getOfficePhone() != null)      profileAttributes.put("marOfficePhone",      profileTo.getOfficePhone())
                if(profileTo.getMobilePhone() != null)      profileAttributes.put("marMobilePhone",      profileTo.getMobilePhone())
                if(profileTo.getSkypeId() != null)          profileAttributes.put("marSkypeId",          profileTo.getSkypeId())
                if(profileTo.getLinkedInId() != null)       profileAttributes.put("marLinkedInId",       profileTo.getLinkedInId())

                def profileId = ""+crafterProfile.getId()
                System.out.println("UPDATING PROFILE WITH EMAIL ADDRESS " + profileTo.getEmail())
                def defaultEmail = this.DEFAULT_EMAIL
                def email = ("NOT_FOUND".equals(profileTo.getEmail()) || "UNSET".equals(profileTo.getEmail()) ) ? defaultEmail :  profileTo.getEmail()
                crafterProfile = crafterProfileService.updateProfile(profileId, null, null, email, true, null, profileAttributes)

                if(crafterProfile != null) {
                    this.logInfo("Invalidating cached profile for user: [" + profileTo.getUserName() + "]");
                    this.invalidateProfileInCache()

                    status = true
                }
                else {
                    throw new Exception("Profile not updated for username: " + profileTo.getUserName())
                }
            }
            else {
                throw new Exception("No profile returned for username: " + profileTo.getUserName())
            }
        }

        return status
    }

    public UserProfile getActiveProfile() {
        return this.request.getAttribute("crafterSiteProfile")
    }

    public void setActiveProfile(UserProfile profile) {
        this.request.setAttribute("crafterSiteProfile", profile )
    }


    public UserProfile pupulateUserProfileWithFakeData(Object profileTo) {
        profileTo.setCrafterProfileId("FAKE-PROFILEID-" + profileTo.getRoleID())

        profileTo.setTitle("A Job Title")
        profileTo.setPreferredName("David")
        profileTo.setOfficePhone("703-867-5309")
        profileTo.setMobilePhone("703-777-9357")
        profileTo.setSkypeId("ASkypeId")
        profileTo.setLinkedInId("aLinkdInId")

        return profileTo
    }


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
     * invalidate user from session
     * If sessionCachingEnabled is false, method does nothing
     * profiles in session because server is sticky sessioned to a particular tomcat
     */
    private boolean invalidateProfileInCache() {
        def result = true

        if(this.sessionCachingEnabled) {
            def session = this.request.getSession()

            if(session != null) {
                session.removeAttribute(this.PROFILE)
            }
        }

        return result
    }

    /**
     * attempt to cache a user from session
     * If sessionCachingEnabled is false, method does nothing
     * profiles in session because server is sticky sessioned to a particular tomcat.
     */
    private boolean cacheProfile(UserProfile profileToCache) {
        boolean result = false

        if(this.sessionCachingEnabled) {
            def session = this.request.getSession()

            if(session != null) {
                session.setAttribute(this.PROFILE, profileToCache)
                result = true
            }
        }

        return result
    }

    /**
     * attempt to get a cached user from session
     * If sessionCachingEnabled is false, method does nothing
     * profiles in session because server is sticky sessioned to a particular tomcat.
     */
    private UserProfile getCachedProfile() {
        UserProfile cachedUserProfile = null

        if(this.sessionCachingEnabled) {
            def session = this.request.getSession()

            if(session != null) {
                try {
                    cachedUserProfile = session.getAttribute(this.PROFILE)
                }
                catch(ClassCastException castError) {
                    // somone updated the profile object and now the new class
                    // does not match the cached class, throw this cached object out!
                    logInfo("Cached profile is trash because profile class has been updated, throwing it away.")
                    invalidateProfileInCache()
                    cachedUserProfile = null
                }
            }
        }

        return cachedUserProfile
    }

    /**
     * unfortunately this class can be initialized without a logger so we need this method
     * bail us out
     */
    public void logInfo(message) {
        if(this.logger != null) {
            this.logger.info(message)
        }
        else {
            System.out.println(message)
        }
    }
}