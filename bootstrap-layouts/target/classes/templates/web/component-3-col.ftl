<#import "/templates/system/common/cstudio-support.ftl" as studio />


        
<div <@studio.componentAttr path=model.storeUrl ice=false /> style='width:100%; overflow:hidden;' >


        <div <@studio.componentContainerAttr target="zone1" objectId=model.objectId /> style='width:33%; float:left;'>
			<#if model.zone1?? &&  model.zone1.item?? >
              <#list model.zone1.item as module>
                  <@renderComponent component=module />
              </#list>
            </#if>
        </div>


		<div <@studio.componentContainerAttr target="zone2" objectId=model.objectId /> style='width:33%; float:left;'>
			<#if model.zone2?? &&  model.zone2.item?? >
              <#list contentModel.zone2.item as module>
                  <@renderComponent component=module />
              </#list>
            </#if>
        </div>


		<div <@studio.componentContainerAttr target="zone3" objectId=model.objectId /> style='width:33%; float:left;'>
			<#if model.zone3?? &&  model.zone3.item?? >
              <#list model.zone3.item as module>
                  <@renderComponent component=module />
              </#list>
            </#if>
        </div>


</div>