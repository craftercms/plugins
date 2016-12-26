<#import "/templates/system/common/cstudio-support.ftl" as studio />
<#include "/templates/web/navigation/navigation.ftl">


<div <@studio.componentAttr path=contentModel.storeUrl ice=false /> >

  <ul class='nav'>
      <@renderNavigation "/site/website", contentModel.navDepth_i!1 />
  </ul>

</div>