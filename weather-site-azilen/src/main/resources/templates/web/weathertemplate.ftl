<div class="container">
  <div class="forecast-container">
  <#if channel??>
    <div class="today forecast">
      <div class="forecast-header">
        <div class="day">${channel.item.forecast[0].day}</div>
        <div class="date">${channel.item.forecast[0].date}</div>
      </div> <!-- .forecast-header -->
      <div class="forecast-content">
        <div class="location">${channel.location.city}</div>
        <div class="degree">
          <div class="num">${channel.item.condition.temp}<sup>o</sup>C</div>
          <div class="forecast-icon">
            <img src="${getIconByWeatherText(channel.item.forecast[0].text)}" alt="" width=90 />
          </div>	
        </div>
        
        <span><img src="static-assets/images/icon-umberella.png" alt="">${channel.atmosphere.humidity}%</span>
        <span><img src="static-assets/images/icon-wind.png" alt="">${channel.wind.speed}km/h</span>
        <#-- <span><img src="static-assets/images/icon-compass.png" alt="">East</span> -->
      </div>
    </div>
    <#assign temp = 0 />
    <#list channel.item.forecast as weather>
    	<#if (temp > 0 && temp < 7)>
        	<div class="forecast">
              <div class="forecast-header">
                <div class="day">${weather.day}</div>
              </div> <!-- .forecast-header -->
              <div class="forecast-content">
                <div class="forecast-icon">
                  <img src="${getIconByWeatherText(weather.text)}" alt="" width=48>
                </div>
                <div class="degree">${weather.high}<sup>o</sup>C</div>
                <small>${weather.low}<sup>o</sup></small>
              </div>
            </div>
        </#if>
        <#assign temp=temp+1/>
	</#list>
    </#if>
  </div>
</div>
<#function getIconByWeatherText text>
  <#if text?contains("Sunny") || text?contains("Fair")>
  	<#return "/static-assets/images/icons/icon-2.svg">
  <#elseif text?contains("Thunderstorms")>
  	<#return "/static-assets/images/icons/icon-12.svg">
  <#elseif text?contains("Partly Cloudy")>
  	<#return "/static-assets/images/icons/icon-3.svg">
  <#elseif text?contains("Cloudy")>
  	<#return "/static-assets/images/icons/icon-5.svg">
  <#elseif text?contains("Showers")>
  	<#return "/static-assets/images/icons/icon-10.svg">
  <#elseif text?contains("Haze")>
  	<#return "/static-assets/images/icons/icon-7.svg">
  <#else>
  	<#return "/static-assets/images/icons/icon-1.svg">
  </#if>  
</#function>
<script>
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
</script>