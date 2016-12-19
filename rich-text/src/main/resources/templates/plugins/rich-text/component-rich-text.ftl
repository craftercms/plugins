<#import "/templates/system/common/cstudio-support.ftl" as studio />
<div <@studio.componentAttr path=model.storeUrl ice=true iceGroup="content" /> >${contentModel.content_html!''}</div>
