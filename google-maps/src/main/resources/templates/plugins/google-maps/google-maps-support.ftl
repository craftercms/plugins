<#macro googleMapSupport>
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=AIzaSyAmSs0Y5mkuo-JnOMC71CGzqRdGC8fCUJE&libraries=places"></script>

	<script type="text/javascript">
	      function initializeMap(elId, address) {
	        var geocoder = new google.maps.Geocoder();


	        geocoder.geocode({'address': address},
			  function(results, status) {

              	 if (status == 'OK') {
                   var location = results[0].geometry.location;

                   var mapOptions = {
                      zoom: 12,
                      mapTypeId: google.maps.MapTypeId.ROADMAP
                   };

                   var map = new google.maps.Map(document.getElementById(elId), mapOptions);
                   map.setCenter(location);

                   var marker = new google.maps.Marker({
                      map: map,
                      position: location
                   });
                 }
                 else {
                 	 alert('Geocode was not successful for the following reason: ' + status);
                 }
			  });
	      }
	     </script>
</#macro>

<#macro renderMap id address>
	<#assign cleanAddress = address?replace("\r","")?replace("\n"," ") />
    <div id="${id}" style='border:1px solid black; width: 300px; height: 200px;'></div>
	<script>
	google.maps.event.addDomListener(window, 'load', function() {
	    initializeMap("${id}", "${cleanAddress}");
	});
	</script>
</#macro>