def hubspotPortalId = siteConfig.getString("hubspotPortalId")
hubspotPortalId = (hubspotPortalId != null) ? hubspotPortalId : "62515"

templateModel.hubspotPortalId = hubspotPortalId
