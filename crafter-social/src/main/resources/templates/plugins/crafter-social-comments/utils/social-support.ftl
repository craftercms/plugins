
<#macro commentSupport socializedElementId, contentTitle pageModel>
	<#assign socialContextId = siteConfig.getString("social.socialContextId")!"" />
    <#assign tenantId = "test" />
    
       <!-- SUI Scripts -->
        <script type="text/javascript">

        window.CKEDITOR_BASEPATH = '/social/crafter-social/sui/v2/alt/libs/ckeditor/';
	    var crafterSocial_cfg = {
	        'url.base'                      : '/social/crafter-social/sui/v2/alt/',
	        'url.service'                   : '/social/crafter-social/api/3',
	        'url.security.value'            : '/social/crafter-social/crafter-security-login?tenantName=${tenantId}',
	        'url.security.active'           : 'https://theplatform2.marriott.com/social/crafter-social/crafter-security-current-auth?tenantName=${tenantId}&context=${socialContextId}',
	        'url.templates'                 : '/social/crafter-social/sui/v2/alt/templates/',

            'url.comments': {
                value: "?context=${socialContextId}",
                "{_id}": {
                    value: "?context=${socialContextId}",
                    update:"?context=${socialContextId}",
                    votes: {
                        value: "",
                        neutral: "?context=${socialContextId}",
                        down: "?context=${socialContextId}",
                        up: "?context=${socialContextId}"
                    },
                    flags: {
                        value: "?context=${socialContextId}", // Flag comment flags
                       '{flagId}':"?context=${socialContextId}"
                    },
                    attachments: {
                        value: "",
                        "{fileId}": {
                            "value": "?context=${socialContextId}",
                            "delete": "?context=${socialContextId}"
                        }
                    },
                    moderate: "?context=${socialContextId}"
                }
            }
	    };

	    function crafterSocial_onAppReady ( director, CrafterSocial ) {
	        CrafterSocial.$.extend(CrafterSocial.string.LOCALE,{
	            months: [ 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December' ],
	            days: ['Sunday','Monday','Tuesday','Wednesday', 'Thursday','Friday','Saturday'],
	            'commentable.view-comment': 'View & Comment',
	            'commentable.notify-comment':'Notify on Reply',
	            'popover.no-comment':'(no comments)',
	            'discussion.comment':'Be the first to comment!!',
	            'discussion.login-comment':'',
	            'options.options':'Options',
	            'options.inline':'Inline View',
	            'options.lightbox':'Lightbox View',
	            'options.bubble' :'Bubble View',
	            'options.refresh':'Refresh',
	            'options.close':'Close',
	            'commenting.submissionLabel':'Your submission will not appear until approved by the blog admin.',
    	        'commenting.agreeTermsLabel':'I have read and agree to Terms of Use of this blog',
        	    'commenting.agreeTermsLinkText':'View Terms of Use',
            	'commenting.agreeTermsLink':'https://extranet.marriott.com/mgs/common/communications/social-media/blogs/terms-of-use-for-blogs.html',
            	'comments.flag':'Flag as inappropriate.',
            	'loginForm':'pkmslogin.form',
                'commenting.attachmentsTip': 'Adding photos? Post your comment then add them to your post.'
	        });
		}
		</script>

        <link rel="stylesheet" href="/social/crafter-social/sui/v2/alt/styles/main.css" />
        <script src="/social/crafter-social/sui/v2/alt/scripts/social.js"></script>
        
        <script>
		crafter.social.getDirector().on(crafter.social.Constants.get('EVENT_USER_AUTHENTICATION_SUCCESS'),
			function(profile) {
        var $ = crafter.social.$;
				var director = crafter.social.getDirector();
                
				$('.crafter-social-commentable').each(function() {
					var contentId = "${socializedElementId}";
					var title = "${contentTitle}";
                     
                    
					if (contentId != undefined) {
                   
						director.socialise({
							target: '.' + contentId,
							context: '${socialContextId}',
							commentUrl:'${pageModel.getStoreUrl()?replace("/site/website","")?replace("/index.xml","")}',
							commentThreadName: title,
							view:{
								'parasite':{
									'cfg':{
										'discussionView':'view.Inline',
										'mobileView':'view.Inline',
										'mobileExpanded': true
									}
								}
							}
						});
					}
				});
			}
	    );

		</script>

</#macro>