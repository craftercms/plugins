import org.craftercms.engine.service.context.SiteContext;

def sitemap = [:]
def excludeContentTypes = ['/component/level-descriptor']
def baseUrl=request.getScheme() +"://"+request.getServerName() + ("http".equals(request.getScheme()) && request.getServerPort() == 80 || "https".equals(request.getScheme()) && request.getServerPort() == 443 ? "" : ":" + request.getServerPort() );
sitemap.put('/site/website/index.xml', [url:baseUrl, previewUrl:baseUrl]);

def parseSiteItem;

try {
    parseSiteItem = {
        currentItem, result ->
            if (currentItem.isFolder()) {
                def children = currentItem.childItems;
                children.each { child ->
                    parseSiteItem(child, result);
                }
            } else {
                def contentType = currentItem.queryValue('content-type')
                if (!excludeContentTypes.contains(contentType)) {
                    def currentItemUrl = currentItem.getStoreUrl();
                    def currentItemLocation = baseUrl + urlTransformationService.transform('storeUrlToRenderUrl', currentItemUrl);
                    def urls = [url:currentItemLocation, previewUrl:currentItemLocation]
                    result.put(currentItemUrl, urls);
                }
            }
    }


    def siteTree = siteItemService.getSiteTree("/site/website", 10)
    if(siteTree) {
        def items = siteTree.childItems;
        items.each { siteItem ->
            parseSiteItem(siteItem, sitemap);
        }
    }

    response.setContentType("application/xml")
    def xml = new groovy.xml.MarkupBuilder(response.getWriter())

    def xmlHelper = new groovy.xml.MarkupBuilderHelper(xml)
    xmlHelper.xmlDeclaration(version:"1.0", encoding:"UTF-8")

    def count = 0

    xml.urlset(xmlns:"http://www.sitemaps.org/schemas/sitemap/0.9") {
        sitemap.each { k, v ->
            url {
                SiteContext context = SiteContext.current;
                if (context.overlayCallback != null) {
                    loc(v.previewUrl)
                } else {
                    loc(v.url)
                }
                changefreq("daily")
            }
        }
    }

}
catch (ex) {
    logger.error("error while generating sitemap "+ex)
}  