<#import "/templates/system/common/cstudio-support.ftl" as studio />
<@controller path="/scripts/plugins/profile/profile-page.groovy" />

<!DOCTYPE html>
<html>
    <head>
    </head>

    <body>

        <h1>Profile Attributes</h1>
        <ul>
            <li>${userProfile.firstName}</li>
            <li>${userProfile.lastName}</li>
            <li>${userProfile.title}</li>
            <li>${userProfile.preferredName}</li>
            <li>${userProfile.officePhone}</li>
            <li>${userProfile.mobilePhone}</li>
            <li>${userProfile.skypeId}</li>
            <li>${userProfile.linkedInId}</li>
         </ul>

    </body>
</html>