
def DEMO_PORTAL_ID = "62515"
def hubspotPortalId = DEMO_PORTAL_ID

if(siteConfig != null) {
    hubspotPortalId = siteConfig.getString("hubspotPortalId")

    hubspotPortalId = (hubspotPortalId != null) ? hubspotPortalId : DEMO_PORTAL_ID
}

templateModel.hubspotPortalId = hubspotPortalId
