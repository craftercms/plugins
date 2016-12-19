def DEFAULT_SLIDE_SET = siteItemService.getSiteItem("/site/components/slider-sets/default.xml")

model.slideSet = DEFAULT_SLIDE_SET
profile = request.session.getAttribute("_cr_profile_state")

def profileSegment = (profile) ? profile.get("segment") : "all"
profileSegment = (profileSegment) ? profileSegment : "all"

def queryStatement = 'crafterSite:"' + siteContext.siteName  + '" ' +
                     'AND content-type:"/component/slider-set" ' +
                     'AND ((segment.item.key:"' + profileSegment  + '")^10 OR segment.item.key:"all") '

def query = searchService.createQuery()
query = query.setQuery(queryStatement)

def executedQuery = searchService.search(query)    
def itemsFound = executedQuery.response.numFound    
def items = executedQuery.response.documents

if(itemsFound > 0) {
	def targetedSlideId = items[0].localId
    def targetedItem = siteItemService.getSiteItem(targetedSlideId)
    
    if(targetedItem) {
	    model.slideSet = targetedItem
    }
}
