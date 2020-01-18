<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>

<@c.page>
Registration page
${message!}
<@l.login "/registration"/>
</@c.page>
