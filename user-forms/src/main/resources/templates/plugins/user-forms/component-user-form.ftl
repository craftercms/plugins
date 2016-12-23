<#import "/templates/system/common/cstudio-support.ftl" as studio />

<div <@studio.componentAttr path=contentModel.storeUrl ice=true /> >
	<#assign formId = contentModel.objectId?replace('-','') />
	<form>
    	<#list contentModel.fields.item as field>

        	<label>${field.label} <#if field.required='true'><span class='required'>*</span></#if>

                <#if field.type=="Input">
                  <input type='text' id='${formId}-${field.id}' value='${field.defaultValue!""}' />
            	<#elseif field.type=="Text Area">
                  <textarea type='text' id='${formId}-${field.id}'>${field.defaultValue!""}'</textarea>
            	<#elseif field.type=="Boolean">
                 <input type='checkbox' id='${formId}-${field.id}' <#if field.defaultValue?? && field.defaultValue=="true">checked='true'</#if> />
            	</#if>
            </label>

        </#list>
         <button type="${formId}sumbit" onclick='return ${formId}submit();'>${submitButtonLabel!"Submit"}</button>

      </form>

	<div class="modal fade ${formId}Dialog" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
      <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
          ${contentModel.result!"Submitted"}
        </div>
      </div>
    </div>

         <script>
         	function ${formId}submit() {
            	var values = [];
                values[0] = "${contentModel.storeUrl}";

                <#list contentModel.fields.item as field>
        			values[${field_index}+1] = { label: "${field.label}", value: document.getElementById("${formId}-${field.id}") };
				</#list>

                  $.ajax({
                  	type: "POST",
                    url: "/api/1/services/forms/submit-form.json",
                    data: values,
                  	success: function(data) {
                    	<#if contentModel.onSubmitAction??>
                          <#if contentModel.onSubmitAction == "Redirect">
                              document.location = "${contentModel.result}";
                          <#elseif contentModel.onSubmitAction == "Display Message">
                        	$('#${formId}Dialog').modal("true");

                          </#if>
                        <#else>
                        	$('#${formId}Dialog').modal({ show: 'true' });
                        </#if>
					},
                    failure: function() {
                    }
				  });

                return false;
            }
    </script>
</div>