<#import "/templates/system/common/cstudio-support.ftl" as studio />

<div class="testimonial"
     <#if contentModel.position != "Inline">style="float:${contentModel.position};"</#if>
     <@studio.componentAttr path=contentModel.storeUrl ice=true  /> >
    <p>${contentModel.body!""}</p>
    <div class="whopic">
        <div class="arrow"></div>
        <img class="centered" src='${contentModel.headshot!"/static-assets/plugins/quote/images/quote_thumbnail.jpg"}' alt="${contentModel.name!""}" />
        <strong>
              <small>${contentModel.name!""}</small>
            <small>${contentModel.title!""}, ${contentModel.company!""}</small>
        </strong>
    </div>
</div>

<style>
.testimonial p {
    //color:#181A1C;
    color:black;
    //background:#FECE1A;
    background:#CCCCCC;
    padding:15px;
    margin:0;
}
.testimonial .arrow {
    margin-left:10px;
    width:0;
    //border-top:10px solid #FECE1A;
    border-top:10px solid #CCCCCC;
    border-left: 20px outset transparent;
    border-right: 20px outset transparent;
}
.testimonial .whopic {
    display:inline-block;
}
.testimonial .whopic img {
    margin-top:10px;
    width:50px;
    height:50px;
    float:left;
}
.testimonial .whopic strong {
    float:left;
    margin-top:10px;
    padding-left:10px;
}
.testimonial .whopic small {
    display:block;
    font-size:12px;

}
.testimonial-text{
    display:block;
    font-size:22px;
    text-align:center;
    margin:0 auto;
    margin-top:30px;
    width:70%;
    line-height:1.3em;
}
</style>