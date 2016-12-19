<#import "/templates/system/common/cstudio-support.ftl" as studio />

<!DOCTYPE html>
<html>

  <head>
  </head>
  
  <body>

      <main class="main"  >

		<div <@studio.componentContainerAttr target="col1" objectId=model.objectId /> >
		<#if contentModel.col1?? && contentModel.col1.item?? >
          <#list contentModel.col1.item as module>
			<@renderComponent component=module />
		  </#list>
     	</#if>  
        </div>
      </main>
  

  
      <@studio.toolSupport />
  
  </body>
</html>