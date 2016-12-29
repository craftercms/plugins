<#macro renderComponents componentList>
  <#if componentList?? && componentList.item??>
    <#list componentList.item as module>
      <@renderComponent component=module />
    </#list>
  </#if>
</#macro>

<#macro renderRTEComponents model>

  <#assign componentCount = model['count(//rteComponents//item/id)'] />

  <#if componentCount == 1 >
      <#assign curComponentPath = ""+model['//rteComponents//item/contentId'] />
    <div style='display:none' id='o_${model['//rteComponents//item/id']}'>
      <#-- @renderComponent component=model['//rteComponents//item'] /-->
      <@renderComponent componentPath=curComponentPath />
    </div>

     <#assign item = siteItemService.getSiteItem(curComponentPath) />
     <@renderRTEComponents model=item />

  <#elseif (componentCount > 1) == true >
    <#assign components = model['//rteComponents//item'] />
    <#list components as c>
          <#if c.id??>
              <div style='display:none' id='o_${c.id}'>
          <#assign curComponentPath = "" + c.contentId />
                   <@renderComponent componentPath=curComponentPath />
              </div>

         <#assign item = siteItemService.getSiteItem(curComponentPath) />
         <@renderRTEComponents model=item />
          </#if>
    </#list>
  </#if>
</#macro>


<#macro pluginSupport>
  <@controller path="/scripts/system/plugin-support.groovy" />
</#macro>

<#macro renderPluginFtlImports>

  <#list pluginResources as resource>
    <#if resource.ftlImports?? && resource.ftlImports.item??>
      <#list resource.ftlImports.item as import>
        <@"<#import '${import.path}' as ${import.namespace} />"?interpret />
      </#list>
    </#if>



  </#list>

</#macro>

<#macro renderPluginFtlScriptCode>
    <#list pluginResources as resource>
      <#if resource.ftlCode??>
      <@"${resource.ftlCode}"?interpret />
    </#if>
  </#list>
</#macro>

<#macro renderPluginTopScripts>

  <#list pluginResources as resource>
    <#if resource.scripts?? && resource.scripts.item??>
      <#list resource.scripts.item as script>
        <#if script.location="Top">
          <script src="${script.path}"></script>
        </#if>
      </#list>
      </#if>

  </#list>

</#macro>

<#macro renderPluginBottomScripts>
  <#list pluginResources as resource>
    <#if resource.scripts?? && resource.scripts.item??>
      <#list resource.scripts.item as script>
        <#if script.location="Bottom">
          <script src="${script.path}"></script>
        </#if>
      </#list>
      </#if>

  </#list>
</#macro>

<#macro renderPluginStyleSheets>
  <#list pluginResources as resource>
    <#if resource.stylesheets?? && resource.stylesheets.item??>
      <#list resource.stylesheets.item as stylesheet>
          <link rel="stylesheet" href="${stylesheet.path}" type="text/css" />
      </#list>
      </#if>

  </#list>
</#macro>
