// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestOAuth20ServiceB008{
    /***
        public func revokeTokenAsync(tokenToRevoke: String): Future<Unit>
        测试场景:鉴权失败
    ***/
    @Skip
    @TestCase
    func testOAuth20ServiceRevokeTokenAsync0101(): Unit {
        //将这些替换为在【授权服务器-微博】中生成的 client_id 和 client_secret
        let clientId: String = "your client id"
        let clientSecret: String = "your client secret"



        //替换成自己需要请求的，受保护的资源的链接
        //授权成功拿到访问令牌后，准备请求的受保护的资源的链接
        let PROTECTED_RESOURCE_URL_0: String = "https://api.weibo.com/2/users/show.json"
        let PROTECTED_RESOURCE_URL: String = "https://api.weibo.com/2/account/get_uid.json"

        let service: OAuth20Service = ServiceBuilderOAuth20(clientId).
                setApiSecret(clientSecret).
                //设置回调url{redirect_uri}，用于后面获取授权码code
                setCallback("http://www.example.com/response").
                build(WeiboApi.instance())


        //=== 微博的OAuth工作流 ===

        //RFC 7009 OAuth 2.0令牌吊销

        //1. 获取授权 URL

        //1.1 生成可以获取授权码的链接
        //授权认证服务器通过回调地址{redirect_uri}将【用户授权码】code 传递给【应用服务器】或者直接在 Webview 中跳转到携带用户授权码的回调地址上，
        //Webview(网页) 直接获取 code 即可。({redirect_uri}?code=abc)
        let authorizationUrl: String = AuthorizationUrlBuilder(service).build()

        println("授权URL: " + authorizationUrl)

        //1.2 替换成上一步生成的一次性授权码
        //let code: String = "your code"
        let code: String = "ffa4482988ac884f7ce9a22436c8dc60ca800cc0eeef320fbe18dfc689d1442a"

        //2.获取访问令牌！
        let accessToken: OAuth2AccessToken = service.getAccessToken(code)
        let rawResponse: String = accessToken.getRawResponse()
        println("(访问令牌-原始响应如下：" + rawResponse + "')")

        //3. 从原始响应rawResponse的json字符串中拿到uid
        let jsonResponse = JsonValue.fromStr(rawResponse).asObject()
        let uid: String = jsonResponse.get("uid").getOrThrow().asString().getValue()

        //4.请求一个受保护的资源！--根据用户ID获取用户信息
        //RFC 6750 OAuth 2.0授权框架：承载令牌使用
        let requestUrl: String = PROTECTED_RESOURCE_URL_0
        let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, requestUrl)
        request.addQuerystringParameter("uid", uid)
        //4.1 请求签名
        service.signRequest(accessToken, request)
        //4.2 调用同步请求执行
        let response = service.execute(request)
        @Assert(response.getCode(),200)

        //5.撤销令牌
        //RFC 7009 OAuth 2.0令牌吊销
        println("执行撤销令牌")
        service.revokeTokenAsync(accessToken.getAccessToken())

        //6.请求一个受保护的资源！--获取uid
        //RFC 6750 OAuth 2.0授权框架：承载令牌使用
        let requestUrl2: String = PROTECTED_RESOURCE_URL
        let request2: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, requestUrl2)
        //6.1 请求签名
        service.signRequest(accessToken, request2)
        //6.2 调用同步请求执行
        let response2 = service.execute(request2)
        @Assert(response2.getCode(),403)
    }
}