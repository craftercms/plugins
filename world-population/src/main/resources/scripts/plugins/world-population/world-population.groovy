import groovy.json.JsonSlurper

def country = contentModel.country.text
def countryUrl = java.net.URLEncoder.encode(country)
def population = 1

// service does not like + encoding for spaces
countryUrl = countryUrl.replace("+", "%20")

def externalServiceHost = "http://api.population.io/1.0"
def externalServiceURL = "/population/"+countryUrl+"/today-and-tomorrow/"

// call the service
def response = (externalServiceHost+externalServiceURL).toURL().getText()

try {
    // parse service's the JSON response to an object
    def result = new JsonSlurper().parseText( response )
    population = result.total_population[0].population
}
catch(err) {
}

templateModel.country = country
templateModel.population = population