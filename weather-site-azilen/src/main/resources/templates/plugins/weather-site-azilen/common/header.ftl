<#import "/templates/system/common/cstudio-support.ftl" as studio />

<head>
  	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0,maximum-scale=1">
    
    <title>Azilen Weather</title>
    
    <!-- Loading third party fonts -->
    <link href="http://fonts.googleapis.com/css?family=Roboto:300,400,700|" rel="stylesheet" type="text/css">
    <link href="/static-assets/plugins/weather-site-azilen/fonts/font-awesome.min.css" rel="stylesheet" type="text/css">
    
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
     <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    
    <!-- Loading main css file -->
    <link rel="stylesheet" href="/static-assets/plugins/weather-site-azilen/css/style.css">
    
    <script src="/static-assets/js/jquery-1.11.1.min.js"></script>

  </head>


<div class="site-content">
			<div class="site-header">
				<div class="container">
					<a href="index.html" class="branding">
						<img src="static-assets/plugins/weather-site-azilen/images/logo.png" alt="" class="logo">
						<div class="logo-type">
							<h1 class="site-title">Weather</h1>
						</div>
					</a>

					<!-- Default snippet for navigation -->
					<div class="main-navigation">
						<button type="button" class="menu-toggle"><i class="fa fa-bars"></i></button>
						<ul class="menu">
							<li class="menu-item" id="menuHome"><a href="index.html">Home</a></li>
							<li class="menu-item" id="menuNews"><a href="/news">News</a></li>
                            <li class="menu-item" id="menuPhotos"><a href="/photos">Photos</a></li>
						</ul> <!-- .menu -->
					</div> <!-- .main-navigation -->

					<div class="mobile-navigation"></div>
                  
              </div>
  </div> 