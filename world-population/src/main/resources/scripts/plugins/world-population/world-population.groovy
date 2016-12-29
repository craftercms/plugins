@Grapes(
        @Grab(group='org.codehaus.groovy.modules.http-builder', module='http-builder', version='0.6')
)

import groovy.json.JsonSlurper
import groovyx.net.http.HTTPBuilder
import groovyx.net.http.Method
import groovyx.net.http.ContentType

def country = contentModel.country.text
def countryUrl = java.net.URLEncoder.encode(country)
def population = 1

// service does not like + encoding for spaces
countryUrl = countryUrl.replace("+", "%20")

def externalServiceHost = "http://api.population.io/1.0"
def externalServiceURI = "/population/"+countryUrl+"/today-and-tomorrow/"
def externalServiceURL = externalServiceHost + externalServiceURI

def http = new HTTPBuilder()

http.request( externalServiceURL, Method.GET, ContentType.JSON ) { req ->

    headers.Accept = 'application/json'

    response.success = { resp, reader ->
        def response = reader

        try {
            population = response.total_population[0].population
        }
        catch(err) {
            logger.error("Unable to get population :"+err)

        }
    }
}

templateModel.country = country
templateModel.population = population