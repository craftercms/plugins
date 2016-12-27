<#macro QRCodeSupport>
    <script src="/static-assets/plugins/qr-code/scripts/jquery.qrcode.js" ></script>
    <script src="/static-assets/plugins/qr-code/scripts/qrcode.js" ></script>
</#macro>

<#macro renderQRCode id, message>
    <div id="${id}"></div>
    <script>$('#${id}').qrcode("${message}");</script>
</#macro>