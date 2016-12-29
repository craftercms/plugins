<#import "/templates/system/common/cstudio-support.ftl" as studio />

<section id="${contentModel.sectionID}" <@studio.componentAttr path=contentModel.storeUrl ice=true /> >
  
<div class="content-wrap" <@studio.componentContainerAttr target="sectionZone1" objectId=contentModel.objectId />>
  <#if contentModel.sectionZone1?? &&  contentModel.sectionZone1.item?? >
      <#list contentModel.sectionZone1.item as module>
              <@renderComponent component=module />
        </#list>
    </#if>
    </div>

</section>