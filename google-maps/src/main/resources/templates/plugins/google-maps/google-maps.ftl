<#import "/templates/system/common/cstudio-support.ftl" as studio />
<#import "/templates/plugins/google-maps/google-maps-support.ftl" as maps />

<#assign mapId = contentModel.objectId?replace('-','') />
<div <@studio.componentAttr path=contentModel.storeUrl ice=true  /> >

   <@maps.renderMap "map${mapId}" contentModel.address />

</div>
