// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestOAuth20ServiceB008{
    /***
        public func refreshAccessToken(refreshToken: String,callback: Option<OAuthAsyncRequestCallback>): Future<OAuth2AccessToken>
        测试场景:鉴权成功,refreshToken为正确的token
    ***/
    @Skip
    @TestCase
    func testOAuth20ServiceGetAccessToken0301(): Unit {
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
}