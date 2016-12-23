import java.io.*;
import java.net.*;
import groovy.json.JsonSlurper;

def queryStatement = "category:* & sort=uploadeddate desc"
def matches =[:]
def images=[]

def query = searchService.createQuery()
query = query.setQuery(queryStatement)

def executedQuery = searchService.search(query)

matches.found = executedQuery.response.numFound
images = executedQuery.response.documents

matches.images=images
model.query = queryStatement
model.matches = matches

def cityName = params.q

if(cityName) {  
   String text = new URL("https://query.yahooapis.com/v1/public/yql?q=" + URLEncoder.encode("select * from weather.forecast where woeid in (select woeid from geo.places(1) where text=\"" + cityName + "\") and u=\"c\"", "UTF-8").replaceAll("\\+", "%20") + "&format=json").getText(connectTimeout: 5000, readTimeout: 10000, useCaches: true, allowUserInteraction: false, requestProperties: ['Connection': 'close']);
  
  JsonSlurper jsonSlurper = new JsonSlurper();
  def data = jsonSlurper.parseText(text);
    
	if(data.query.results != null){
		def channel = data.query.results.channel;
		model.channel = channel
	}
    
  
}