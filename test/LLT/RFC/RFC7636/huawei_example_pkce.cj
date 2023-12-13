
from std import collection.*

from oauth4cj import oauth4cj.*

main() {
    //将这些替换为在【授权服务器-华为】中生成的 client_id 和 client_secret
    let clientId: String = "your client id"
    let clientSecret: String = "your client secret"

    //替换成自己需要的权限范围，多个权限用空格隔开
    let SCOP: String = "openid profile"

    //替换成自己需要请求的，受保护的资源的链接
    //授权成功拿到访问令牌后，准备请求的受保护的资源的链接
    let PROTECTED_RESOURCE_URL: String = "https://account.cloud.huawei.com/rest.php?nsp_svc=GOpen.User.getInfo"

    let m: Random = Random()
    m.seed = 3
    let c: UInt32 = m.nextUInt32()
    let secretState: String = "secret" + c.toString()

    let service: OAuth20Service = ServiceBuilderOAuth20(clientId).
            setApiSecret(clientSecret).
            setDefaultScope(SCOP).
            //设置回调url{redirect_uri}，用于后面获取授权码code
            setCallback("http://www.example.com/oauth_callback/").
            build(HuaweiApi.instance())

    //=== 华为的OAuth工作流 ===

    //RFC 7636 OAuth公共客户端（PKCE）代码交换的证明密钥

    //1. 获取授权 URL

    //1.1 准备PKCE
    let strPkce: String = "ceshi20230612"
    let byte: Array<UInt8> = strPkce.toArray()
    let pkce: PKCE = PKCEService.defaultInstance().generatePKCE(RANDOM_BYTES)

    let codeVerifier: String = pkce.getCodeVerifier()
    println("codeVerifier = " + codeVerifier)

    //1.2 生成可以获取授权码的链接
    //授权认证服务器通过回调地址{redirect_uri}将【用户授权码】code 传递给【应用服务器】或者直接在 Webview 中跳转到携带用户授权码的回调地址上，
    //Webview(网页) 直接获取 code 即可。({redirect_uri}?code=abc&state=xyz)
    let authorizationUrl: String = AuthorizationUrlBuilder(service).
            setState(secretState).
            setPkce(pkce).
            build()

    println("授权URL: " + authorizationUrl)

    //1.3 替换成上一步生成的一次性授权码
    //let code: String = "your code"
    let code: String = "ffa4482988ac884f7ce9a22436c8dc60ca800cc0eeef320fbe18dfc689d1442a"

    //2.获取访问令牌！
    let params: AccessTokenRequestParams = AccessTokenRequestParams(code)
    params.setPKCECodeVerifier(codeVerifier)
    let accessToken: OAuth2AccessToken = service.getAccessToken(params)
    println("(访问令牌-原始响应如下：" + accessToken.getRawResponse() + "')")


    //3.请求一个受保护的资源！
    //RFC 6750 OAuth 2.0授权框架：承载令牌使用
    let requestUrl: String = PROTECTED_RESOURCE_URL
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.POST, requestUrl)

    //3.1 请求签名
    service.signRequest(accessToken, request)

    //3.2 调用同步请求执行
    let response: OAuth4cjResponse = service.execute(request)
    println(response.getCode())
    println(response.getBody())
}
