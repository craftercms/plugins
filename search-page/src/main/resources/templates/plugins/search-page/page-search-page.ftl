<#import "/templates/system/common/cstudio-support.ftl" as studio />
<@controller path="/scripts/plugins/search-page/search-page.groovy" />

<!DOCTYPE html>
<html>

  <head>
      <#--include "/templates/web/head.ftl" --/>
  </head>

  <body>

      <#-- include "/templates/web/header.ftl" / -->

      <main class="main" id="main" >

		<h1>Search</h1>
        <form>
          <input  id="query" value="${userQuery}" />
          <button id="searchBtn" onclick="submitSearchForm();">Search</button>
        </form>

        <ul>
	        <#list results as result>
				<li>
                	<h3><a href='${result.link}'>${result.title}</a></h3>
                    <div>${result.description}</div>
                </li>
			</#list>
		</ul>

      </main>

      <#-- include "/templates/web/footer.ftl" / -->
  	 <script>
     	function submitSearchForm() {
        	var userQuery = document.getElementById("query").value;
            var searchLocation = "/search?q=" + userQuery;
        	document.location = searchLocation;

        }
     </script>
  
      <@studio.toolSupport />
  
  </body>
</html>