<#macro login path isRegisterForm>
    <form action="${path}" method="post">
        <div class="form-group row">
            <label for="name" class="col-sm-2 col-form-label">Name: </label>
            <div class="col-sm-6">
                <input id="name" type="text" name="username"
                       class="form-control ${(passwordError??)?string('is-invalid', '')}"
                       placeholder="Username" value="<#if user??>${user.username}</#if>"/>
                <#if  usernameError??>
                    <div class="invalid-feedback">
                        ${usernameError}
                    </div>
                </#if>
            </div>
        </div>
        <div class="form-group row">
            <label for="password" class="col-sm-2 col-form-label">Password: </label>
            <div class="col-sm-6">
                <input id="password" type="password" name="password"
                       class="form-control ${(passwordError??)?string('is-invalid', '')}"
                       placeholder="Password"/>
                <#if  passwordError??>
                    <div class="invalid-feedback">
                        ${passwordError}
                    </div>
                </#if>
            </div>
        </div>
        <#if isRegisterForm>
            <div class="form-group row">
                <label for="passwordConfirm" class="col-sm-2 col-form-label">Password Confirm: </label>
                <div class="col-sm-6">
                    <input id="passwordConfirm" type="password" name="passwordConfirm"
                           class="form-control ${(passwordConfirmError??)?string('is-invalid', '')}"
                           placeholder="Password confirm"/>
                    <#if  passwordConfirmError??>
                        <div class="invalid-feedback">
                            ${passwordConfirmError}
                        </div>
                    </#if>
                </div>
            </div>
        <div class="form-group row">
            <label for="email" class="col-sm-2 col-form-label">Email: </label>
            <div class="col-sm-6">
                <input id="email" type="email" name="email"
                       class="form-control ${(emailError??)?string('is-invalid', '')}"
                       placeholder="mail.google.com" value="<#if user??>${user.email}</#if>"/>
                <#if  emailError??>
                    <div class="invalid-feedback">
                        ${emailError}
                    </div>
                </#if>
            </div>
        </div>
        <div class="col-sm-6">
            <div class="g-recaptcha" data-sitekey="6LevyNAUAAAAAGr15XwsN_StYRkmihG24J1f13Wg"></div>
            <#if captchaError??>
                <div class="alert alert-danger" role="alert">
                    ${captchaError}
                </div>
            </#if>
        </div>
        </#if>
        <div><button type="submit" class="btn btn-primary"><#if !isRegisterForm>Sign in<#else>Register</#if></button></div>
        <#if !isRegisterForm>
            <a href="/registration">Add new user</a>
        </#if>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
    </form>
</#macro>

<#macro logout>
    <form action="/logout" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <button type="submit" class="btn btn-primary">Sign Out</button>
    </form>
</#macro>