/*
def topNavItems = [:]
def siteDir = siteItemService.getSiteTree("/site/website", 2)
if(siteDir) {
    def dirs = siteDir.childItems
    dirs.each { dir ->
            def dirName = dir.getStoreName()
            def dirItem = siteItemService.getSiteItem("/site/website/${dirName}/index.xml")
            if (dirItem != null) {
                def dirDisplayName = dirItem.queryValue('internal-name')
                   topNavItems.put(dirName, dirDisplayName)
            }
   }
}
model.topNavItems = topNavItems;
*/


def queryStatement = 'content-type:"/component/blog" '

def query = searchService.createQuery()
query = query.setQuery(queryStatement)

def executedQuery = searchService.search(query)
def itemsFound = executedQuery.response.numFound
def items = executedQuery.response.documents

templateModel.blogItems = items


queryStatement = 'crafterSite:"sourceamerica" AND content-type:"/page/*" '

query = searchService.createQuery()
query = query.setQuery(queryStatement)

executedQuery = searchService.search(query)
itemsFound = executedQuery.response.numFound
items = executedQuery.response.documents

templateModel.pageItems = items