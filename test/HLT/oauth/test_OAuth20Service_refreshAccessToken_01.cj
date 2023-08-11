// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj


@Test
public class TestOAuth20ServiceB008{
    /***
        public func refreshAccessToken(refreshToken: String): OAuth2AccessToken
        测试场景:鉴权成功,refreshToken为正确的token
    ***/
    @Skip
    @TestCase
    func testOAuth20ServiceRefreshAccessToken01(): Unit {
        //将这些替换为您的客户端id和机密
        let clientId: String = "your client id"
        let clientSecret: String = "your client secret"
        let code: String = "24c3c3bd74186b28f283641079a2c0d808bafe731fd261ae2fe64305aa6c244f"
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
        accessToken = service.refreshAccessToken(accessToken.getRefreshToken())
        accessToken = service.refreshAccessToken(accessToken.getRefreshToken())
        let requestUrl: String = PROTECTED_RESOURCE_URL
        let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, requestUrl)
        service.signRequest(accessToken, request)
        let response = service.execute(request)
        @Assert(response.getCode(),200)
    }
    /***
        public func refreshAccessToken(refreshToken: String, scope: String): OAuth2AccessToken
        测试场景:鉴权成功,refreshToken为正确的token
    ***/
    @Skip
    @TestCase
    func testOAuth20ServiceRefreshAccessToken02(): Unit {
        //将这些替换为您的客户端id和机密
        let clientId: String = "your client id"
        let clientSecret: String = "your client secret"
        let code: String = "3cf2595d211690ee18cdac9509fd15169d2c58b760f3089628719db13cb92e18"
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
        accessToken = service.refreshAccessToken(accessToken.getRefreshToken(),scope)
        accessToken = service.refreshAccessToken(accessToken.getRefreshToken(),scope)
        let requestUrl: String = PROTECTED_RESOURCE_URL
        let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, requestUrl)
        service.signRequest(accessToken, request)
        let response = service.execute(request)
        @Assert(response.getCode(),200)
    }
    /***
        public func refreshAccessToken(refreshToken: String,callback: Option<OAuthAsyncRequestCallback>): Future<OAuth2AccessToken>
        测试场景:鉴权成功,refreshToken为正确的token
    ***/
    @Skip
    @TestCase
    func testOAuth20ServiceRefreshAccessToken03(): Unit {
        //将这些替换为您的客户端id和机密
        let clientId: String = "your client id"
        let clientSecret: String = "your client secret"
        let code: String = "dab1f551da495bc9ec9bfb86e64c1383c52d49f813c82ca2bc2b03b966c2251e"
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
        let subOAuthAsyncRequestCallback01=SubOAuthAsyncRequestCallback()
        let callback=Option<OAuthAsyncRequestCallback>.Some(subOAuthAsyncRequestCallback01)
        var fut_accessToken = service.refreshAccessToken(accessToken.getRefreshToken(),callback)
        accessToken=fut_accessToken.get()
        let requestUrl: String = PROTECTED_RESOURCE_URL
        let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, requestUrl)
        service.signRequest(accessToken, request)
        let response = service.execute(request)
        @Assert(response.getCode(),200)
        @Assert(subOAuthAsyncRequestCallback01.getFlagOnCompleted(),"pass")
        @Assert(subOAuthAsyncRequestCallback01.getFlagOnThrowable(),"fail")
    }
    /***
        public func refreshAccessToken(refreshToken: String, scope: String,callback: Option<OAuthAsyncRequestCallback>): Future<OAuth2AccessToken>
        测试场景:鉴权成功,refreshToken为正确的token
    ***/
    @Skip
    @TestCase
    func testOAuth20ServiceRefreshAccessToken04(): Unit {
        //将这些替换为您的客户端id和机密
        let clientId: String = "your client id"
        let clientSecret: String = "your client secret"
        let code: String = "b5ecf2a653c12f79b63adefb772f44e45482ba2a82334aaac932706ad021264f"
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
        let subOAuthAsyncRequestCallback01=SubOAuthAsyncRequestCallback()
        let callback=Option<OAuthAsyncRequestCallback>.Some(subOAuthAsyncRequestCallback01)
        var fut_accessToken = service.refreshAccessToken(accessToken.getRefreshToken(),scope,callback)
        accessToken=fut_accessToken.get()
        let requestUrl: String = PROTECTED_RESOURCE_URL
        let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, requestUrl)
        service.signRequest(accessToken, request)
        let response = service.execute(request)
        @Assert(response.getCode(),200)
        @Assert(subOAuthAsyncRequestCallback01.getFlagOnCompleted(),"pass")
        @Assert(subOAuthAsyncRequestCallback01.getFlagOnThrowable(),"fail")
    }
    /***
        public func refreshAccessTokenAsync(refreshToken: String): Future<OAuth2AccessToken>
        测试场景:鉴权成功,refreshToken为正确的token
    ***/
    @Skip
    @TestCase
    func testOAuth20ServiceRefreshAccessTokenAsync01(): Unit {
        //将这些替换为您的客户端id和机密
        let clientId: String = "your client id"
        let clientSecret: String = "your client secret"
        let code: String = "24c3c3bd74186b28f283641079a2c0d808bafe731fd261ae2fe64305aa6c244f"
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
        var fut_accessToken = service.refreshAccessTokenAsync(accessToken.getRefreshToken())
        accessToken = fut_accessToken.get()
        let requestUrl: String = PROTECTED_RESOURCE_URL
        let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, requestUrl)
        service.signRequest(accessToken, request)
        let response = service.execute(request)
        @Assert(response.getCode(),200)
    }
    /***
        public func refreshAccessTokenAsync(refreshToken: String, scope: String): Future<OAuth2AccessToken>
        测试场景:鉴权成功,refreshToken为正确的token
    ***/
    @Skip
    @TestCase
    func testOAuth20ServiceRefreshAccessTokenAsync02(): Unit {
        //将这些替换为您的客户端id和机密
        let clientId: String = "your client id"
        let clientSecret: String = "your client secret"
        let code: String = "3cf2595d211690ee18cdac9509fd15169d2c58b760f3089628719db13cb92e18"
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
        var fut_accessToken = service.refreshAccessTokenAsync(accessToken.getRefreshToken(),scope)
        accessToken = fut_accessToken.get()
        let requestUrl: String = PROTECTED_RESOURCE_URL
        let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, requestUrl)
        service.signRequest(accessToken, request)
        let response = service.execute(request)
        @Assert(response.getCode(),200)
    }
}