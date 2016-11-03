<#import "/templates/system/common/cstudio-support.ftl" as studio />

<!DOCTYPE html>
<!-- saved from url=(0029)http://www.sourceamerica.org/ -->
<html>

  <head>
  </head>
  
  <body>
  

      <main>

		<h1>${contentModel.blogTitle}</h1>
        
        <ul>
         <table>
        	<tr>
            	<td style="width:65%" valign='top'>
					<#list blogItems as blog>
             			<h2 id='${blog.localId}' <@studio.componentAttr path=blog.localId ice=true />>${blog.title}</h2>
              			${blog.blogBody_html}
	          		</#list>
                </td>
                <td style='width:100px'>
                <td>
                <td  valign='top'>
                  <h3>Recent Posts</h3>
                  <#list blogItems as blog>
                      <li><a href='#${blog.localId}'>${blog.title}</a></li>
                  </#list>
                </td>
           </tr>
       </table>
        </ul>
      </main>
  
      <@studio.toolSupport />
  
  </body>
</html>