<#import "parts/common.ftlh" as c>

<@c.page>
    <h5>${username}</h5>
    ${message!}
    <form method="post">
        <div class="form-group row">
            <label for="password" class="col-sm-2 col-form-label">Password: </label>
            <div class="col-sm-6">
                <input id="password" type="password" name="password" class="form-control" placeholder="Password" />
            </div>
        </div>
        <div class="form-group row">
            <label for="email" class="col-sm-2 col-form-label">Email: </label>
            <div class="col-sm-6">
                <input id="email" type="email" name="email" class="form-control" placeholder="mail.google.com" value="${email!}"/>
            </div>
        </div>

        <button type="submit" class="btn btn-primary">Save</button>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
    </form>
</@c.page>
