<#import "/templates/system/common/cstudio-support.ftl" as studio />
<@controller path="/scripts/plugins/sitemap/site-map.groovy" />

<!DOCTYPE html>
<!-- saved from url=(0029)http://www.sourceamerica.org/ -->
<html class=" js js no-touch rgba cssanimations csstransforms csstransitions svg csscalc mediaqueries" lang="en" dir="ltr" xmlns:og="http://ogp.me/ns#" xmlns:article="http://ogp.me/ns/article#" xmlns:book="http://ogp.me/ns/book#" xmlns:profile="http://ogp.me/ns/profile#" xmlns:video="http://ogp.me/ns/video#" xmlns:product="http://ogp.me/ns/product#" xmlns:content="http://purl.org/rss/1.0/modules/content/" xmlns:dc="http://purl.org/dc/terms/" xmlns:foaf="http://xmlns.com/foaf/0.1/" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:sioc="http://rdfs.org/sioc/ns#" xmlns:sioct="http://rdfs.org/sioc/types#" xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:xsd="http://www.w3.org/2001/XMLSchema#">

  <head>
      <#--include "/templates/web/head.ftl" --/>
  </head>

  <body class="html front not-logged-in  page-node page-node- page-node-47 node-type-page">

      <#-- include "/templates/web/header.ftl" / -->

      <main class="main" id="main" >

		<h1>Site Map</h1>

        <ul>
         <table>
        	<tr>
                <td valign='top'>
                  <h3>Pages</h3>
                  <#list pageItems as page>
                      <li><a href='#'>${page["internal-name"]}</a></li>
                  </#list>
                </td>

				<td style='width:150px'>
                </td>
                <td  valign='top'>
                  <h3>Recent Posts</h3>
                  <#list blogItems as blog>
                      <li><a href='#'>${blog.title}</a></li>
                  </#list>
                </td>
           </tr>
       </table>
        </ul>
      </main>

      <#-- include "/templates/web/footer.ftl" / -->
  
  
      <@studio.toolSupport />
  
  </body>
</html>