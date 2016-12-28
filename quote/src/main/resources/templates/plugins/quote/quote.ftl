<#import "/templates/system/common/cstudio-support.ftl" as studio />

<div <@studio.componentAttr path=contentModel.storeUrl ice=true  /> >

<div class='quoteBody' <#if contentModel.position != "Inline">style="float:${contentModel.position};"</#if> >
<div class='quoteBodyTop'>
</div>
<div class='quoteBodyMid'>

<div class='quoteBodyContent'>
<#if contentModel.headshot?? && contentModel.headshot == "">
	<img class='quoteImage' src="/static-assets/plugins/quote/images/quote_thumbnail.jpg" >
<#else>
	<img  class='quoteImage'  src='${contentModel.headshot!"/static-assets/plugins/quote/images/quote_thumbnail.jpg"}' >
</#if>

    ${contentModel.body!""}<br>
    ${contentModel.title!""}<br>
    ${contentModel.company!""}
  </div>
</div>
<div class='quoteBodyBottom'>
</div>
</div>

</div>
