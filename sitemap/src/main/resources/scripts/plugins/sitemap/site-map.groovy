def queryStatement = 'content-type:"/component/blog" '

def query = searchService.createQuery()
query = query.setQuery(queryStatement)

def executedQuery = searchService.search(query)
def itemsFound = executedQuery.response.numFound
def items = executedQuery.response.documents

templateModel.blogItems = items


queryStatement = 'crafterSite:"' + siteContext.siteName + '" AND content-type:"/page/*" '

query = searchService.createQuery()
query = query.setQuery(queryStatement)

executedQuery = searchService.search(query)
itemsFound = executedQuery.response.numFound
items = executedQuery.response.documents

templateModel.pageItems = items