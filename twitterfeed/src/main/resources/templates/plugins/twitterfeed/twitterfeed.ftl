<#import "/templates/system/common/cstudio-support.ftl" as studio />
<@controller path="/scripts/plugins/twitterfeed/twitterfeed.groovy" />

<div <@studio.componentAttr path=model.storeUrl ice=true  /> >

	<#if feed??>
      <ul class="twitterfeed">
          <#list feed as item>
              <li>${item.text}</li>
          </#list>
      </ul>
    <#else>
		${errorMessage!"An error occurred."}
    </#if>

</div>