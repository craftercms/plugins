<#import "/templates/system/common/cstudio-support.ftl" as studio />
 
    <div class="container clearfix row" <@studio.componentAttr path=contentModel.storeUrl ice=false />>

      <div class="col_one_fifth" <@studio.componentContainerAttr target="zone1" objectId=contentModel.objectId />>
        <#if contentModel.zone1?? &&  contentModel.zone1.item?? >
            <#list contentModel.zone1.item as module>
                    <@renderComponent component=module />
              </#list>
          </#if>
      </div>

      <div class="col_one_fifth col-md-4" <@studio.componentContainerAttr target="zone2" objectId=contentModel.objectId />>
        <#if contentModel.zone2?? &&  contentModel.zone2.item?? >
            <#list contentModel.zone2.item as module>
                    <@renderComponent component=module />
              </#list>
          </#if>
      </div>


      <div class="col_one_fifth" <@studio.componentContainerAttr target="zone3" objectId=contentModel.objectId />>
        <#if contentModel.zone3?? &&  contentModel.zone3.item?? >
            <#list contentModel.zone3.item as module>
                    <@renderComponent component=module />
              </#list>
          </#if>
      </div>

      <div class="col_one_fifth" <@studio.componentContainerAttr target="zone4" objectId=contentModel.objectId />>
        <#if contentModel.zone4?? &&  contentModel.zone4.item?? >
            <#list contentModel.zone4.item as module>
                    <@renderComponent component=module />
              </#list>
          </#if>
      </div>

      <div class="col_one_fifth col_last" <@studio.componentContainerAttr target="zone5" objectId=contentModel.objectId />>
        <#if contentModel.zone5?? &&  contentModel.zone5.item?? >
            <#list contentModel.zone5.item as module>
                    <@renderComponent component=module />
              </#list>
          </#if>
      </div>

    </div>
