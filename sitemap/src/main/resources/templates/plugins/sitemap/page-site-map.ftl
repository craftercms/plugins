<#import "/templates/system/common/cstudio-support.ftl" as studio />
<@controller path="/scripts/plugins/sitemap/site-map.groovy" />

<!DOCTYPE html>
<html>

  <head>
      <#--include "/templates/web/head.ftl" --/>
  </head>

  <body>

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