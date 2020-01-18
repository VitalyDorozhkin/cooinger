<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>
<@c.page>
    <@l.logout/>
    <a href="/user">User List</a>
<div>
    <form method="post" enctype="multipart/form-data">
        <input type="text" name="text" placeholder="Enter message">
        <input type="text" name="tag" placeholder="Enter tag">
        <input type="file" name="file">
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <button type="submit">Add</button>
    </form>
</div>
<div>
    <form method="get">
        <input type="text" name="filter" placeholder="Enter filter" value="${filter!}">
        <button type="submit">Find</button>
    </form>
</div>
    <p>Messages List</p>
    <#list messages as message>
        <div>
            <b>${message.id}</b>
            <span>${message.text}</span>
            <i>${message.tag}</i>
            <strong>${message.authorName}</strong>
            <#if message.filename??>
                <div>
                    <img src="/img/${message.filename}">
                </div>
            </#if>
        </div>
    <#else>
        No message
    </#list>

</@c.page>