def hubspotPortalId = siteConfig.getString("hubspotPortalId")
    hubspotPortalId = (hubspotPortalId != null) ? hubspotPortalId : "UNSET"

templateModel.hubspotPortalId = hubspotPortalId