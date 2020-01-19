<#import "parts/common.ftlh" as c>
<@c.page>

    <div class="form-group">
        <form method="get" action="/main" class="form-inline">
            <input type="text" class="form-control" name="filter" placeholder="Search by tag" value="${filter!}">
            <button type="submit" class="btn btn-primary ml-2">Search</button>
        </form>
    </div>
    <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
        Add new message
    </button>
    <div class="collapse <#if textError??>show</#if>" id="collapseExample">
        <div class="form-group mt-3">
            <form method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <textarea name="text" placeholder="Enter message" class="form-control ${(textError??)?string('is-invalid', '')}" id="text">
                        <#if message??>${message.text}</#if>
                    </textarea>
                    <#if  textError??>
                     <div class="invalid-feedback">
                         ${textError}
                     </div>
                    </#if>
                </div>
                <div class="form-group">
                    <input type="text" name="tag" placeholder="Enter tag" class="form-control ${(tagError??)?string('is-invalid', '')}" id="tag" value="<#if message??>${message.tag}</#if>">
                    <#if  tagError??>
                        <div class="invalid-feedback">
                            ${tagError}
                        </div>
                    </#if>
                </div>
                <div class="custom-file form-group">
                    <input type="file" name="file" class="custom-file-input" id="customFile">
                    <label class="custom-file-label" for="customFile">Choose file</label>
                </div>
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <div class="form-group mt-3">
                    <button type="submit" class="btn btn-primary">Cooing!</button>
                </div>
            </form>
        </div>
    </div>
    <div class="card-columns">
    <#list messages as message>
        <div class="card my-3" style="width: 18rem;">
            <div class="card-body">
                <h5 class="card-title">${message.authorName}</h5>
                <p class="card-text">${message.text}</p>
            </div>
                <#if message.filename??>
                    <img src="/img/${message.filename}" class="card-img-bottom">
                </#if>
            <div class="card-footer text-muted">
                <i>${message.tag}</i>
            </div>
        </div>
    <#else>
        No messages
    </#list>
    </div>

</@c.page>