import scripts.api.SiteServices

import groovy.json.JsonSlurper

def context = SiteServices.createContext(applicationContext, request)
def siteConfiguration = SiteServices.getConfiguration(context, params.site, "/site-config.xml", false)

def hubspotAPIkey = siteConfiguration.hubspotAPIkey
hubspotAPIkey = (hubspotAPIkey != null) ? hubspotAPIkey : "demo"

def getFormsUrl = "https://api.hubapi.com/forms/v2/forms?hapikey="+hubspotAPIkey

def serviceResponse = (getFormsUrl).toURL().getText()

def hubspotForms = new JsonSlurper().parseText( serviceResponse )

def results = []

hubspotForms.each { form ->
    def item = [:]
    item.id = form.guid
    item.name = form.name

    results.add(item)
}

return results