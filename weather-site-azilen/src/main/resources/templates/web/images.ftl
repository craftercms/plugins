<#import "/templates/system/common/cstudio-support.ftl" as studio />
<html lang="en">


<#include "/templates/web/common/header.ftl" />
<body>
	<link rel="stylesheet" href="/static-assets/css/style.css">
      <div class="container">
        <#list matches.images as image>
          <div class="col-md-6 col-sm-2">
            <div class="live-camera">
              <figure class="live-camera-cover"><img id="myImg" style="height: 350px !important;width: 800px !important;" src="${image.image}" alt="${image.description}" onclick="return imgclick(this.src, this.alt)"></figure>
              <h3 class="location">${image.imageTitle}</h3>
              <small class="date">${image.description}</small>
          </div>  
          </div>    
        </#list>
       </div> 
      
      
      
      
      
      <!-- The Modal -->
<div id="imgModal" class="modal">
  <span class="close">×</span>
  <img class="modal-content" id="imgInModel">
  <div id="caption"></div>
</div>

	<script src="/static-assets/js/custom.js"></script>   
</body>
<script>
 $('#menuPhotos').addClass(" current-menu-item");
</script>
<#include "/templates/web/common/footer.ftl" />
