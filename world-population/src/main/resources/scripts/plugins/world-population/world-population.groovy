import groovy.json.JsonSlurper

def country = contentModel.country.text
def countryUrl = java.net.URLEncoder.encode(country)

// service does not like + encoding for spaces
countryUrl = countryUrl.replace("+", "%20")

def externalServiceHost = "http://api.population.io/1.0"
def externalServiceURL = "/population/"+countryUrl+"/today-and-tomorrow/"

// call the service
def response = (externalServiceHost+externalServiceURL).toURL().getText()

// parse service's the JSON response to an object
def result = new JsonSlurper().parseText( response )


templateModel.country = country
templateModel.population = result.total_population[0].population