<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>

<@c.page>
Registration page
${usernameError!}
<@l.login "/registration" true/>
</@c.page>
