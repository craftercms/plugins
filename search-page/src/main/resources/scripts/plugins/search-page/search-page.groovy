def userQuery = (params.q != null) ? params.q : ""

def results = []
def itemsFound = 0

if(!"".equals(userQuery)) {
    def queryStatement = 'crafterSite:"' + siteContext.siteName + '" AND content-type:"/page/*"'

    if(!"".equals(userQuery)) {
        queryStatement += " AND *:"+userQuery
    }

    def query = searchService.createQuery()
    query = query.setQuery(queryStatement)

    def executedQuery = searchService.search(query)
    def items = executedQuery.response.documents
    itemsFound = executedQuery.response.numFound

    items.each { item ->
        def result = [:]

        result.title = (item.title != null) ? item.title : item['internal-name']
        result.link = item.localId.replace("/index.xml", "").replace("/site/website", "")
        result.description = (item.body_html != null) ? item.body_html : (item.content_html != null) ? item.content_html : ""

        results.add(result)
    }
}

templateModel.userQuery = userQuery
templateModel.results = results
templateModel.resultsFound = itemsFound
