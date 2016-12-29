/**
 * ideally we would use the tree query method here but there is an NPE atm
 */
def queryStatement = 'content-type:"/plugins/blogs/blog" '

def query = searchService.createQuery()
query = query.setQuery(queryStatement)
query = query.addParam("sort", "lastModifiedDate_dt desc")

def executedQuery = searchService.search(query)
def itemsFound = executedQuery.response.numFound
def items = executedQuery.response.documents

templateModel.blogItems = items
