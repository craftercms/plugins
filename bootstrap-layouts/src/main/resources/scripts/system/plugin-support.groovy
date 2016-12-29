import java.util.HashSet

def contentTypes = new HashSet<String>()
def processedDescriptors = new HashSet<String>()

def foundComponentTypes = getComponentTypes(contentModel.storeUrl, processedDescriptors, contentTypes, siteItemService)
def pluginResources = getPluginResources(contentTypes, siteItemService)

templateModel.pluginResources = pluginResources


/**
 * given a list of component types, load resources if any in to an array
 */
private getPluginResources(contentTypes, siteItemService) {
	def supportDetails = []

 	contentTypes.each { type ->
 		def resourceItemPath = "/site/plugin-resources"+type+"/resource.xml"
 		def resourceItem = siteItemService.getSiteItem(resourceItemPath)

 		if(resourceItem) {
 			supportDetails.add(resourceItem)
 		}
 	}

 	return supportDetails
}

/**
 * given a item ID, build a list of content type for the item and all of it's child items.
 */
private getComponentTypes(itemId, processedDescriptors, contentTypes, siteItemService) {

	// check that descriptor needs processing
	if(!processedDescriptors.contains(itemId)) {
		// process the itme
		def item = siteItemService.getSiteItem(itemId)

		if(item) {
			// add item the list so it is not processed again later
			processedDescriptors.add(itemId)

			def contentType = item.queryValue("content-type")
			
			if(contentType) {
				contentTypes.add(contentType)
			} 

			// get the children and process them
			def childComponentIds = item.queryValues("//item/key[contains(text(),'.xml')]")
			childComponentIds.each { id ->

				contentTypes = getComponentTypes(id, processedDescriptors, contentTypes, siteItemService)
			}
		}
	}

	return contentTypes
}