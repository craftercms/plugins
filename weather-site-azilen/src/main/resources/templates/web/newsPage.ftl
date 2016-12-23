<#import "/templates/system/common/cstudio-support.ftl" as studio />
<html lang="en">
<head>
	  <head>
  	<title>Azilen Tube</title>
    
    <script type="application/javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
    <!-- bootstrap -->
    <link href="static-assets/css/bootstrap.min.css" rel='stylesheet' type='text/css' media="all" />
    <!-- //bootstrap -->
    <link href="static-assets/css/dashboard.css" rel="stylesheet">
    <!-- Custom Theme files -->
    <link href="static-assets/css/style.css" rel='stylesheet' type='text/css' media="all" />
    <script src="static-assets/js/jquery-1.11.1.min.js"></script>
    <!--start-smoth-scrolling-->
    <!-- fonts -->
    <link href='//fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>
    <link href='//fonts.googleapis.com/css?family=Poiret+One' rel='stylesheet' type='text/css'>
    <!-- //fonts -->
  </head>
</head>
	<body>
    <script type="text/javascript">
    	$(function(){
        	fetchNews();
            loadIframe();
            $('#menuNews').addClass(" current-menu-item");
        });

		function loadIframe(){
        
        var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&'); 
            for (var i = 0; i < url.length; i++) {  
                var urlparam = url[i].split('=');  
                if (urlparam[0] == "url") {  
                    $("#news-frame").show();
                	$("#news-frame").attr("src",urlparam[1]);
                   
                }  
            }
        }

        function fetchNews(){
        $(".column").empty();
            if(($('#newsSource').val() != "") && ($('#sortBy').val() != "")){
                console.log("applying filter")
                $("#news-frame").hide();
               
            }
            
        	$.ajax({
            url:'/api/1/services/newsFinder.json',
            data: { newsSourceVal: $('#newsSource').val(), sortByVal : $('#sortBy').val()} ,
            dataType:'json',
            success : function(result){
            	var colAdd = document.createDocumentFragment();
                var toAdd = document.createDocumentFragment();

                for(j in JSON.parse(result.news).articles){
                  var newDiv = document.createElement('div')
                      var colDiv = document.createElement('div')
                          var titleValue = JSON.parse(result.news).articles[j].title;
                  var descriptionValue = JSON.parse(result.news).articles[j].description;
                  
                  newDiv.className = 'news';
                  
                  newDiv.innerHTML = '<h3>'+titleValue+'</h3><p>'+descriptionValue+'</p>';
                  
                  colDiv.className = 'col-md-6';
                  colDiv.id='col'+j;
                  toAdd.appendChild(newDiv);
                  colAdd.appendChild(colDiv);

                  colDiv.appendChild(toAdd);
                }
                document.getElementById('newsRow').appendChild(colAdd);                                 
              }
            });
        }
    </script>
    <#include "/templates/web/common/header.ftl" />
    	
        <div class="container">
    	<label>Please select the news source</label>
    	<select id="newsSource">
          <option value="">select</option>
          <option value="the-times-of-india" selected="selected">The Times of India</option>
          <option value="time">Time</option>
          <option value="the-hindu">The Hindu</option>
          <option value="cnn">CNN</option>
        </select>
		
        
        <label>Sort By</label>
    	<select  id="sortBy">
          <option value="">Select</option>
          <option value="top" selected="selected">Top</option>
          <option value="popular">Popular</option>
          <option value="latest">Latest</option>
          
        </select>
		
        <button type="button" id="search" class="btn" onclick="fetchNews();">Submit</button>
        </div>
        
    	<div class="fullwidth-block" data-bg-color="#262936">
          <div class="container">
          
            <iframe id="news-frame" style="display:none;height:500px;width:100%;" src="http://www.google.com">
              <p>Your browser does not support iframes.</p>
            </iframe>
            <h2 class="section-title">News</h2>
            <div class="column" id="newsRow">
              
            </div>
          </div>
      	</div>
      <#include "/templates/web/common/footer.ftl" />
	<@studio.toolSupport/>
	</body>
</html>