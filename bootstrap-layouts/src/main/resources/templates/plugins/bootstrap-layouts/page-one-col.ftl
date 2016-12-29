<#import "/templates/system/common/cstudio-support.ftl" as studio />
<#import "/templates/system/common/crafter-support.ftl" as crafter />

<@crafter.pluginSupport />

<@crafter.renderPluginFtlImports />

<!DOCTYPE html>
<html dir="ltr" lang="en-US">
<head>

	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta name="author" content="SemiColonWeb" />

	<link rel="stylesheet" href="/static-assets/plugins/bootstrap-layouts/css/bootstrap.min.css">

    <script type="text/javascript" src="/static-assets/plugins/bootstrap-layouts/scripts/jquery.core.js"></script>
    <script type="text/javascript" src="/static-assets/plugins/bootstrap-layouts/scripts/bootstrap.min.js"></script>

	<@crafter.renderPluginStyleSheets />

    <@crafter.renderPluginTopScripts />

	<@crafter.renderPluginFtlScriptCode />

	<title>${contentModel.navLabel!""}</title>
</head>

<body class="stretched">

	<div id="wrapper" class="clearfix" <@studio.componentContainerAttr target="col1" objectId=contentModel.objectId />>
	    <#if contentModel.col1?? && contentModel.col1.item??>
	        <#list contentModel.col1.item as module>
				<@renderComponent component=module />
			</#list>
		</#if>
	</div>

	<div id="gotoTop" class="icon-angle-up"></div>

    <@crafter.renderPluginBottomScripts />

	<@studio.toolSupport />

</body>
</html>