import java.io.*
import java.net.*

def news = []
def result = [:]


def key = siteConfig.getString("newsApiKey")
logger.debug("Api Key= "+key)

def newsSource = params.newsSourceVal
def sortBy = params.sortByVal

String strNews = ""

logger.debug("newsSource "+newsSource)
logger.debug("sortBy "+sortBy)

if(newsSource && sortBy){
	System.out.println("inside if")
	strNews = new URL("https://newsapi.org/v1/articles?source="+newsSource+"&sortBy="+sortBy+"&apiKey="+key)
        .getText(connectTimeout: 5000, readTimeout: 10000, useCaches: true, allowUserInteraction: false, requestProperties: ['Connection': 'close'])
	logger.info("strNews "+strNews);
}
else{
System.out.println("inside else")
	strNews = new URL("https://newsapi.org/v1/articles?source=time&sortBy=latest&apiKey="+key)
        .getText(connectTimeout: 5000, readTimeout: 10000, useCaches: true, allowUserInteraction: false, requestProperties: ['Connection': 'close'])
       logger.info("strNews "+strNews);

}


result.news=strNews

return result;