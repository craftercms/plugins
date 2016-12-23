

<#import "/templates/system/common/cstudio-support.ftl" as studio />

<div class="col-md-6 col-sm-4">
  <div class="live-camera">
  	<a href="/photos?cat=${model.category}">
      <figure class="live-camera-cover"><img style="height: 200px !important;width: 350px !important;" src="${model.image}" alt="No Image"></figure>
      <h3 class="location">${model.category}</h3>
    </a>
  </div>
</div>

<@studio.toolSupport />