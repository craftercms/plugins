def category = params.cat?.trim()?params.cat:'*'
logger.info("category "+category)
def currentSite = siteContext.siteName;
logger.info("currentSite "+currentSite);

def queryStatement = "category:"+category+" AND crafterSite:"+currentSite+""
def matches =[:]
def images=[]


def query = searchService.createQuery()
query = query.setQuery(queryStatement)
query = query.setRows(Integer.MAX_VALUE)


def executedQuery = searchService.search(query)

matches.found = executedQuery.response.numFound
images = executedQuery.response.documents

matches.images=images
model.query = queryStatement
model.matches = matches