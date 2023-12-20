// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj


@Test
public class TestOAuth20ServiceB008{
    /***
        public func getAccessToken(code: String): OAuth2AccessToken
        测试场景:鉴权成功
    ***/
    @Skip
    @TestCase
    func testOAuth20ServiceGetAccessToken01(): Unit {
        //将这些替换为您的客户端id和机密
        let clientId: String = "your client id"
        let clientSecret: String = "your client secret"
        let code: String = "b180f081b6989b3c599864f348e930f33ac5b84786fb40e76eddddb2cebaa540"
        let scope: String = "user_info emails"

        let PROTECTED_RESOURCE_URL: String = "https://gitee.com/api/v5/emails"
        let service: OAuth20Service = ServiceBuilderOAuth20(clientId).
                setApiSecret(clientSecret).
                setDefaultScope(scope).
                setCallback("http://www.example.com/oauth_callback/").
                build(GiteeApi.instance())
        let additionalParams: HashMap<String, String> = HashMap<String, String>()
        additionalParams.put("access_type", "offline")//pass access_type=offline 以获取刷新令牌
        additionalParams.put("prompt", "consent")//强制reget刷新令牌（如果不是第一次询问用户）

        var accessToken: OAuth2AccessToken = service.getAccessToken(code)

        let requestUrl: String = PROTECTED_RESOURCE_URL
        let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, requestUrl)
        service.signRequest(accessToken, request)

        let response = service.execute(request)
        @Assert(response.getCode(),200)
    }
    /***
        public func getAccessToken(params: AccessTokenRequestParams): OAuth2AccessToken
        测试场景:鉴权成功
    ***/
    @Skip
    @TestCase
    func testOAuth20ServiceGetAccessToken02(): Unit {
        //将这些替换为您的客户端id和机密
        let clientId: String = "your client id"
        let clientSecret: String = "your client secret"
        let code: String = "353bd1fba3687f704e6f228ac03781843a72d7251663ae58fd3a9b919341912a"
        let scope: String = "user_info emails"
        let PROTECTED_RESOURCE_URL: String = "https://gitee.com/api/v5/emails"
        let service: OAuth20Service = ServiceBuilderOAuth20(clientId).
                setApiSecret(clientSecret).
                setDefaultScope(scope).
                setCallback("http://www.example.com/oauth_callback/").
                build(GiteeApi.instance())
        let additionalParams: HashMap<String, String> = HashMap<String, String>()
        additionalParams.put("access_type", "offline")//pass access_type=offline 以获取刷新令牌
        additionalParams.put("prompt", "consent")//强制reget刷新令牌（如果不是第一次询问用户）
        let accessTokenRequestParams01=AccessTokenRequestParams(code)
        var accessToken = service.getAccessToken(accessTokenRequestParams01)
        let requestUrl: String = PROTECTED_RESOURCE_URL
        let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, requestUrl)
        service.signRequest(accessToken, request)

        let response = service.execute(request)
        @Assert(response.getCode(),200)

    }
    /***
        public func getAccessToken(params: AccessTokenRequestParams,callback: Option<OAuthAsyncRequestCallback>): Future<OAuth2AccessToken>
        测试场景:鉴权成功
    ***/
    @Skip
    @TestCase
    func testOAuth20ServiceGetAccessToken03(): Unit {
        //将这些替换为您的客户端id和机密
        let clientId: String = "your client id"
        let clientSecret: String = "your client secret"
        let code: String = "9a6a09bf4828c12ad48452ea47cc0e1d0e15c5f41475bbc58ab8bc8c86e68438"
        let scope: String = "user_info emails"

        let PROTECTED_RESOURCE_URL: String = "https://gitee.com/api/v5/emails"
        let service: OAuth20Service = ServiceBuilderOAuth20(clientId).
                setApiSecret(clientSecret).
                setDefaultScope(scope).
                setCallback("http://www.example.com/oauth_callback/").
                build(GiteeApi.instance())
        let additionalParams: HashMap<String, String> = HashMap<String, String>()
        additionalParams.put("access_type", "offline")//pass access_type=offline 以获取刷新令牌
        additionalParams.put("prompt", "consent")//强制reget刷新令牌（如果不是第一次询问用户）
        let accessTokenRequestParams01=AccessTokenRequestParams(code)
        let subOAuthAsyncRequestCallback01=SubOAuthAsyncRequestCallback()
        let callback=Option<OAuthAsyncRequestCallback>.Some(subOAuthAsyncRequestCallback01)
        var fut_accessToken = service.getAccessToken(accessTokenRequestParams01,callback)
        var accessToken=fut_accessToken.get()
        let requestUrl: String = PROTECTED_RESOURCE_URL
        let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, requestUrl)
        service.signRequest(accessToken, request)

        let response = service.execute(request)
        @Assert(response.getCode(),200)

        @Assert(subOAuthAsyncRequestCallback01.getFlagOnCompleted(),"pass")
        @Assert(subOAuthAsyncRequestCallback01.getFlagOnThrowable(),"fail")
    }
    /***
        public func getAccessToken(code: String,callback: Option<OAuthAsyncRequestCallback>): Future<OAuth2AccessToken>
        测试场景:鉴权成功
    ***/
    @Skip
    @TestCase
    func testOAuth20ServiceGetAccessToken04(): Unit {
        //将这些替换为您的客户端id和机密
        let clientId: String = "your client id"
        let clientSecret: String = "your client secret"
        let code: String = "ddba4a84eb0fb2b11163ddd074041e7a7d3b4b9bbf39fd9b13ab9a3dd22d8545"
        let scope: String = "user_info emails"

        let PROTECTED_RESOURCE_URL: String = "https://gitee.com/api/v5/emails"
        let service: OAuth20Service = ServiceBuilderOAuth20(clientId).
                setApiSecret(clientSecret).
                setDefaultScope(scope).
                setCallback("http://www.example.com/oauth_callback/").
                build(GiteeApi.instance())
        let additionalParams: HashMap<String, String> = HashMap<String, String>()
        additionalParams.put("access_type", "offline")//pass access_type=offline 以获取刷新令牌
        additionalParams.put("prompt", "consent")//强制reget刷新令牌（如果不是第一次询问用户）
        let subOAuthAsyncRequestCallback01=SubOAuthAsyncRequestCallback()
        let callback=Option<OAuthAsyncRequestCallback>.Some(subOAuthAsyncRequestCallback01)
        var fut_accessToken = service.getAccessToken(code,callback)
        var accessToken=fut_accessToken.get()
        let requestUrl: String = PROTECTED_RESOURCE_URL
        let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, requestUrl)
        service.signRequest(accessToken, request)

        let response = service.execute(request)
        @Assert(response.getCode(),200)

        @Assert(subOAuthAsyncRequestCallback01.getFlagOnCompleted(),"pass")
        @Assert(subOAuthAsyncRequestCallback01.getFlagOnThrowable(),"fail")
    }
    /***
        public func getAccessTokenAsync(code: String): Future<OAuth2AccessToken>
        测试场景:鉴权成功
    ***/
    @Skip
    @TestCase
    func testOAuth20ServiceGetAccessTokenAsync01(): Unit {
        //将这些替换为您的客户端id和机密
        let clientId: String = "your client id"
        let clientSecret: String = "your client secret"
        //替换成自己的一次性授权码
        let CODE: String = "20ea4fda763dc06cacd02a905c2903419e60c8a5accbc74b982239455fe3eadc"
        //替换成自己需要的权限范围
        let SCOP: String = "user_info emails"
        let PROTECTED_RESOURCE_URL: String = "https://gitee.com/api/v5/emails"
        let service: OAuth20Service = ServiceBuilderOAuth20(clientId).
                setApiSecret(clientSecret).
                setDefaultScope(SCOP).
                setCallback("http://www.example.com/oauth_callback/").
                build(GiteeApi.instance())
        //=== GitHub的OAuth工作流 ===
        //获取授权URL
        //https://developers.google.com/identity/protocols/OAuth2WebServer#preparing-to-start-the-oauth-20-flow
        let additionalParams: HashMap<String, String> = HashMap<String, String>()
        additionalParams.put("access_type", "offline")//pass access_type=offline 以获取刷新令牌
        additionalParams.put("prompt", "consent")//强制reget刷新令牌（如果不是第一次询问用户）
        //替换成自己的一次性授权码
        let code: String = CODE
        //获取访问令牌！
        var fut_accessToken= service.getAccessTokenAsync(code)
        var accessToken = fut_accessToken.get()
        let requestUrl: String = PROTECTED_RESOURCE_URL
        let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, requestUrl)
        service.signRequest(accessToken, request)
        let response = service.execute(request)
        @Assert(response.getCode(),200)
    }
    /***
        public func getAccessTokenAsync(params: AccessTokenRequestParams): Future<OAuth2AccessToken>
        测试场景:鉴权成功
    ***/
    @Skip
    @TestCase
    func testOAuth20ServiceGetAccessTokenAsync02(): Unit {
        //将这些替换为您的客户端id和机密
        let clientId: String = "your client id"
        let clientSecret: String = "your client secret"
        let code: String = "91b6320ba118c77bc40947471b56d64aa04308952b932fe73aa7a9c00fefe5c1"
        let scope: String = "user_info emails"
        let PROTECTED_RESOURCE_URL: String = "https://gitee.com/api/v5/emails"
        let service: OAuth20Service = ServiceBuilderOAuth20(clientId).
                setApiSecret(clientSecret).
                setDefaultScope(scope).
                setCallback("http://www.example.com/oauth_callback/").
                build(GiteeApi.instance())
        let additionalParams: HashMap<String, String> = HashMap<String, String>()
        additionalParams.put("access_type", "offline")//pass access_type=offline 以获取刷新令牌
        additionalParams.put("prompt", "consent")//强制reget刷新令牌（如果不是第一次询问用户）
        let accessTokenRequestParams01=AccessTokenRequestParams(code)
        var fut_accessToken = service.getAccessTokenAsync(accessTokenRequestParams01)
        var accessToken=fut_accessToken.get()
        let requestUrl: String = PROTECTED_RESOURCE_URL
        let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, requestUrl)
        service.signRequest(accessToken, request)

        let response = service.execute(request)
        @Assert(response.getCode(),200)
    }
}