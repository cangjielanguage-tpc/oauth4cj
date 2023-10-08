
//from std import console.*
from std import random.*
from std import collection.*

from oauth4cj import oauth4cj.*

main() {

    //将这些替换为在【授权服务器-gitee】中生成的 client_id 和 client_secret
    let clientId: String = "your client id"
    let clientSecret: String = "your client secret"

    //替换成自己需要的权限范围
    //此授权范围是在【授权服务器-gitee】成功创建的应用中对应的权限描述，多个权限用空格隔开
    let SCOP: String = "user_info emails"

    let NETWORK_NAME: String = "Gitee"

    //替换成自己需要请求的，受保护的资源的链接
    //授权成功拿到访问令牌后，准备请求的受保护的资源的链接
    let PROTECTED_RESOURCE_URL: String = "https://gitee.com/api/v5/emails"

    let m: Random = Random()
    m.seed = 3
    let c: UInt32 = m.nextUInt32()

    let secretState: String = "secret" + c.toString()
    let service: OAuth20Service = ServiceBuilderOAuth20(clientId).
            setApiSecret(clientSecret).
            setDefaultScope(SCOP).
            setCallback("http://www.example.com/oauth_callback/").
            build(GiteeApi.instance())


    //=== Gitee的OAuth工作流 ===

    //1. 获取授权 URL
    //1.1 对授权连接中的配置，进行设置
    let additionalParams: HashMap<String, String> = HashMap<String, String>()
    //通过设置 access_type=offline 以获取刷新令牌
    additionalParams.put("access_type", "offline")
    //强制reget刷新令牌（如果不是第一次询问用户）
    additionalParams.put("prompt", "consent")

    //1.2 生成可以获取授权码的链接
    //授权认证服务器通过回调地址{redirect_uri}将【用户授权码】code 传递给【应用服务器】或者直接在 Webview 中跳转到携带用户授权码的回调地址上，
    //Webview(网页) 直接获取 code 即可。（{redirect_uri}?code=abc&state=xyz)
    let authorizationUrl: String = AuthorizationUrlBuilder(service).
            setState(secretState).
            setAdditionalParams(additionalParams).
            build()
    println("授权URL: " + authorizationUrl)

    //1.3 获取授权码 -- 执行1.3.1 或者 1.3.2
    // Webview(网页)打开上面的授权链接authorizationUrl，返回链接({redirect_uri}?code=abc&state=xyz)

    //1.3.1 替换成返回链接({redirect_uri}?code=abc&state=xyz)，中生成的一次性授权码code
    //let code: String = "your code"

    //1.3.2 替换成返回链接({redirect_uri}?code=abc&state=xyz)，函数extractAuthorization解析code
    // Webview(网页)打开上面的授权链接authorizationUrl，返回的链接({redirect_uri}?code=abc&state=xyz)

    let redirectLocation: String = "http://www.example.com/oauth_callback/?code=${your code}&state=${your state}"

    println("授权后返回的链接: " + redirectLocation)
    let o2a: OAuth2Authorization = service.extractAuthorization(redirectLocation)
    let code: String = o2a.getCode()
    println("拿到授权码：" + code)

    //2.获取访问令牌！
    var accessToken: OAuth2AccessToken = service.getAccessToken(code)
    println("(访问令牌-原始响应如下：" + accessToken.getRawResponse() + "')")

    //3.刷新访问令牌...
    accessToken = service.refreshAccessToken(accessToken.getRefreshToken())
    println("(刷新令牌-原始响应如下：" + accessToken.getRawResponse() + "')")

    //4.请求一个受保护的资源！
    let requestUrl: String = PROTECTED_RESOURCE_URL
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, requestUrl)

    //4.1 请求签名
    service.signRequest(accessToken, request)

    //4.2 调用同步请求执行
    let response: OAuth4cjResponse = service.execute(request)
    println(response.getCode())
    println(response.getBody())

}
