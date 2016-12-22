<#import "/templates/system/common/cstudio-support.ftl" as studio />
<html>
  <head>
  	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0,maximum-scale=1">
    
    <title>Azilen Weather</title>
    
    <#assign cityName = RequestParameters["q"]!"">
    
    <!-- Loading third party fonts -->
    <link href="http://fonts.googleapis.com/css?family=Roboto:300,400,700|" rel="stylesheet" type="text/css">
    <link href="/static-assets/fonts/font-awesome.min.css" rel="stylesheet" type="text/css">
    
    <!-- Loading main css file -->
    <link rel="stylesheet" href="/static-assets/css/style.css">
    
    <script src="/static-assets/js/jquery-1.11.1.min.js"></script>

  </head>

  <body>
  	<#include "/templates/web/common/header.ftl" />

		<!-- .site-header -->

			<div class="hero" data-bg-image="/static-assets/images/banner.png">
				<div class="container">
					<form action="#" class="find-location">
						<input type="text" placeholder="Find your location..." id="cityName">
						<input type="submit" value="Find" id="btnSearchWeather">
					</form>
				</div>
			</div>
            
            
			<div class="forecast-table">
				<@renderComponent componentPath="/site/components/weather.xml" />
			</div>
            
            
			<main class="main-content">
				<div class="fullwidth-block">

				<div class="fullwidth-block" data-bg-color="#262936">
					<div class="container">
                    <h2 class="section-title">News</h2>
						<div class="column" id="newsRow">
										
						</div>
					</div>
				</div>
                
                <div class="fullwidth-block">
  					<div class="container">
    					<h2 class="section-title">Awesome Photos</h2>     
                        	<#list contentModel.imagegallery.item as module>
                                <@renderComponent component=module />
                            </#list>
                      </div>
                  </div>
				
                 <div class="fullwidth-block">
					<div class="container">
						<@renderComponent componentPath="/site/components/quote.xml" />
					</div>
				</div>
			</main> <!-- .main-content -->
			
            <div id="loadingImage" class="loading" style="display:none;" >
            </div>
            
			<!-- .site-footer -->
            <#include "/templates/web/common/footer.ftl" />
		
		
		<script src="/static-assets/js/jquery-1.11.1.min.js"></script>
		<script src="/static-assets/js/plugins.js"></script>
		<script src="/static-assets/js/app.js"></script>
    	<script src="/static-assets/js/custom.js"></script>
        
		<@studio.toolSupport/>	
	</body>
</html>
<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script> 
<script>
	if('${cityName}' == '') {
      var geocoder;
      var fullCityName = '';
      
      // Get the latitude and the longitude;
      function successFunction(position) {
        var lat = position.coords.latitude;
        var lng = position.coords.longitude;
        codeLatLng(lat, lng);
      }
  
      function errorFunction() {
        //alert("Geocoder failed");
      }
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(successFunction, errorFunction);
      }
      function initialize() {
        geocoder = new google.maps.Geocoder();
      }
  
      function codeLatLng(lat, lng) {
        var latlng = new google.maps.LatLng(lat, lng);
        var cityNm = '',
            stateNm = '';
        initialize();
        geocoder.geocode({
          latLng: latlng
        }, function (results, status) {
          if (status == google.maps.GeocoderStatus.OK) {
            if (results[1]) {
              var arrAddress = results;
              $.each(arrAddress, function (i, address_component) {
                if (address_component.types[0] == "locality") {
                  cityNm = address_component.address_components[0].long_name;
                }
                if (address_component.types[0] == "administrative_area_level_1") {
                  stateNm = address_component.address_components[0].short_name;
                }
              });
              fullCityName = cityNm + ', ' + stateNm;
              getCityWeather(fullCityName);
            } else {
              alert("No results found");
            }
          } else {
            alert("Geocoder failed due to: " + status);
          }
        });
      }
  
      function getCityWeather(fullCityName) {
        var query = encodeURI('select * from weather.forecast where woeid in (select woeid from geo.places(1) where text="' + fullCityName + '") and u="c"');
        var weatherURL = 'https://query.yahooapis.com/v1/public/yql?q=' + query + '&format=json';
        $.ajax({
          url: weatherURL,
          success: function (data) {
            if (data != null && data.query != undefined && data.query.results != undefined) {
              populateWeatherDetails(data.query.results.channel);
            }
          }
        });
      }
  
      function populateWeatherDetails(channel) {
        if (channel != undefined) {
          // Today Section
          var todayforecastDiv = $('<div>', { "class": "today forecast" });
          var forecastHeader = $('<div>', { "class": "forecast-header" });
          var forecastContent = $('<div>', { "class": "forecast-content" });
          
          var sup = "<sup>o</sup>";
          
          var dayDiv = $('<div>', { "class": "day" });
          dayDiv.html(channel.item.forecast[0].day);
          
          var dateDiv = $('<div>', { "class": "date" });
          dateDiv.html(channel.item.forecast[0].date);
          
          forecastHeader.append(dayDiv).append(dateDiv);
          
          var locationDiv = $('<div>', { "class": "location" });
          locationDiv.html(channel.location.city);
          
          var degreeDiv = $('<div>', { "class": "degree" });
          var numDiv = $('<div>', { "class": "num" });
          numDiv.html(channel.item.condition.temp + sup + 'C');
          
          var forecastIcon = $('<div>', { "class": "forecast-icon" });
          forecastIcon.html('<img src="/static-assets/images/icons/' + getIconByWeatherText(channel.item.forecast[0].text) + '" alt="" width=90>');
          degreeDiv.append(numDiv).append(forecastIcon);
          
          var humiditySpan = $('<span>');
          humiditySpan.html('<img src="/static-assets/images/icon-umberella.png" alt="">' + channel.atmosphere.humidity + '%');
          
          var windSpan = $('<span>');
          windSpan.html('<img src="/static-assets/images/icon-wind.png" alt="">' + channel.wind.speed + 'km/h');
          
          forecastContent.append(locationDiv).append(degreeDiv).append(humiditySpan).append(windSpan);
          
          todayforecastDiv.append(forecastHeader).append(forecastContent);
          
          $('.forecast-container').empty().append(todayforecastDiv);
          // Section from tomorrow onwards

          for(var i in channel.item.forecast) {
            if(i > 0 && i < 7) {
              var weather = channel.item.forecast[i];
              var forecast = $('<div>', {"class" : "forecast"});
              var header = $('<div>', {"class" : "forecast-header"});
              var content = $('<div>', {"class" : "forecast-content"});
              
              var day = $('<div>', {"class" : "day"});
              day.html(weather.day);
              header.append(day);
              
              var degree = $('<div>', {"class" : "degree"});
              
              degree.html(weather.high + sup + 'C');
              
              var icon = $('<div>', { "class": "forecast-icon" });
          	  icon.html('<img src="/static-assets/images/icons/' + getIconByWeatherText(weather.text) + '" alt="" width=48>');
              
              content.append(icon).append(degree).append('<small>' + weather.low + sup + 'C');
              forecast.append(header).append(content);
              
              $('.forecast-container').append(forecast);
            }
          }
        }
      }      
	}
    function getIconByWeatherText(text) {
      if(text.includes('Sunny') || text.includes('Fair')) {
        return "icon-2.svg";
      } else if(text.includes('Thunderstorms')) {
        return "icon-12.svg";
      } else if(text.includes('Partly Cloudy')) {
        return "icon-3.svg";
      } else if(text.includes('Cloudy')) {
        return "icon-5.svg";
      } else if(text.includes('Showers')) {
        return "icon-10.svg";
      } else if(text.includes('Haze')) {
        return "icon-7.svg";
      } else {
        return "icon-1.svg";
      }
    }
    
     $('#menuHome').addClass(" current-menu-item");
 
  
</script>