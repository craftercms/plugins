<#import "/templates/system/common/cstudio-support.ftl" as studio />
<@controller path="/scripts/plugins/twitterfeed/twitterfeed.groovy" />

<div <@studio.componentAttr path=model.storeUrl ice=true  /> >

	<#if feed??>
      <ul class="twitterfeed">
          <#list feed as item>
              <blockquote class='twitter-tweet'>
              <#assign media = item.mediaEntities />
              <#if media?? && media[0]??>
                <div style='padding-top:5px;'><img src="${media[0].mediaURL}"/></div>
              </#if>

              <p>${item.text}</p></blockquote>
          </#list>
      </ul>
    <#else>
		${errorMessage!"An error occurred."}
    </#if>

</div>
<style>
blockquote.twitter-tweet {
  display: inline-block;
  font-family: "Helvetica Neue", Roboto, "Segoe UI", Calibri, sans-serif;
  font-size: 12px;
  font-weight: bold;
  line-height: 16px;
  border-color: #eee #ddd #bbb;
  border-radius: 5px;
  border-style: solid;
  border-width: 1px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.15);
  margin: 10px 5px;
  padding: 0 16px 16px 16px;
  max-width: 468px;
}

blockquote.twitter-tweet p {
  font-size: 16px;
  font-weight: normal;
  line-height: 20px;
}

blockquote.twitter-tweet a {
  color: inherit;
  font-weight: normal;
  text-decoration: none;
  outline: 0 none;
}

blockquote.twitter-tweet a:hover,
blockquote.twitter-tweet a:focus {
  text-decoration: underline;
}
</style>