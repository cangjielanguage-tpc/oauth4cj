// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestOAuth20ServiceB008{
    /***
        public func refreshAccessTokenAsync(refreshToken: String, scope: String): Future<OAuth2AccessToken>
        测试场景:鉴权成功,refreshToken为正确的token
    ***/
    @Skip
    @TestCase
    func testOAuth20ServiceGetAccessToken0201(): Unit {
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