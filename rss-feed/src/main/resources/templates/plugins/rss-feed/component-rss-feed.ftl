<#import "/templates/system/common/cstudio-support.ftl" as studio />
<@controller path="/scripts/plugins/rss-feed/rss-feed.groovy" />

<div <@studio.componentAttr path=contentModel.storeUrl ice=true iceGroup="content" /> >

    <ul>
        <#list feed as entry>
            <li><h2><a href='${entry.link}' target='_new'>${entry.title}</a></h2>
            <div>${entry.description}</div></li>
        </#list>
    </ul>
</div>

