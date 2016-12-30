<#import "/templates/system/common/cstudio-support.ftl" as studio />
<div <@studio.componentAttr path=contentModel.storeUrl ice=true /> style='<#if contentModel.position!='Inline'>float:${contentModel.position};</#if> margin:${contentModel.margin}px;'>
  <#if  RequestParameters['preview']??   >
      <img src='http://img.youtube.com/vi/${model.youtubeId!"NO-ID"}/0.jpg?rel=0' style="height:${contentModel.height}px;width:${contentModel.width}px;" ></img>
  <#else>
      <iframe style="padding:5px;" width="${contentModel.width}px" height="${contentModel.height}px" src="http://www.youtube.com/embed/${model.youtubeId}?rel=0" frameborder="0" allowfullscreen="true"></iframe>
  </#if>
</div>
