
//from std import console.*
from std import random.*
from std import collection.*

from oauth4cj import commons.*
from oauth4cj import oauth.*
from oauth4cj import model.*
from oauth4cj import httpclient.*
from oauth4cj import builder.*
from oauth4cj import extractors.*
from oauth4cj import exceptions.*

main() {

    //将这些替换为在【授权服务器-github】中生成的 client_id 和 client_secret
    let clientId: String = "your client id"
    let clientSecret: String = "your client secret"

    //替换成自己需要的权限范围,多个权限用 "," 隔开
    let SCOP: String = "repo,user"

    let NETWORK_NAME: String = "Github"

    //替换成自己需要请求的，受保护的资源的链接
    //授权成功拿到访问令牌后，准备请求的受保护的资源的链接
    let PROTECTED_RESOURCE_URL: String = "https://api.github.com/user"

    let m: Random = Random()
    m.seed = 3
    let c: UInt32 = m.nextUInt32()
    let secretState: String = "secret" + c.toString()

    let service: OAuth20Service = ServiceBuilderOAuth20(clientId).
            setApiSecret(clientSecret).
            setDefaultScope(SCOP).
            //设置回调url{redirect_uri}，用于后面获取授权码code
            setCallback("http://www.example.com/oauth_callback/").
            build(GithubApi.instance())


    //=== GitHub的OAuth工作流 ===

    //RFC 6749 OAuth 2.0授权框架，授权代码授权授予

    //1. 生成可以获取授权码的链接
    //授权认证服务器通过回调地址{redirect_uri}将【用户授权码】code 传递给【应用服务器】或者直接在 Webview 中跳转到携带用户授权码的回调地址上，
    //Webview(网页) 直接获取 code 即可。({redirect_uri}?code=abc&state=xyz)
    let authorizationUrl: String = AuthorizationUrlBuilder(service).
            setState(secretState).
            build()

    println("授权URL: " + authorizationUrl)

    //2. 获取授权码 -- 执行2.1 或者 2.2
    // Webview(网页)打开上面的授权链接authorizationUrl，返回链接({redirect_uri}?code=abc&state=xyz)

    //2.1 替换成返回链接({redirect_uri}?code=abc&state=xyz)，中生成的一次性授权码code
    //let code: String = "your code"

    //2.2 替换成返回链接({redirect_uri}?code=abc&state=xyz)，函数extractAuthorization解析code
    // Webview(网页)打开上面的授权链接authorizationUrl，返回的链接({redirect_uri}?code=abc&state=xyz)
    let redirectLocation: String = "http://www.example.com/oauth_callback/?code=9e39959cf411bdacc5c3"
    println("授权后返回的链接: " + authorizationUrl)
    let o2a: OAuth2Authorization = service.extractAuthorization(redirectLocation)
    let code: String = o2a.getCode()

    //3.获取访问令牌！
    let accessToken: OAuth2AccessToken = service.getAccessToken(code)
    println("(访问令牌-原始响应如下：" + accessToken.getRawResponse() + "')")


    //4.请求一个受保护的资源！
    //RFC 6750 OAuth 2.0授权框架：承载令牌使用
    let requestUrl: String = PROTECTED_RESOURCE_URL
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, requestUrl)

    //4.1 请求签名
    service.signRequest(accessToken, request)

    //4.2 调用同步请求执行
    let response: Response = service.execute(request)
    println(response.getCode())
    println(response.getBody())

}
