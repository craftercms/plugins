<#import "/templates/system/common/cstudio-support.ftl" as studio />
<#import "/templates/plugins/qr-code/qr-code-support.ftl" as qrcode />
<#assign qrcodeId = contentModel.objectId?replace('-','') />
<div <@studio.componentAttr path=contentModel.storeUrl ice=true  /> >

   <@qrcode.renderQRCode qrcodeId contentModel.message />

</div>
